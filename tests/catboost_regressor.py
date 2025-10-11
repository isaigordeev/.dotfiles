# Import required libraries
import numpy as np
import pandas as pd
from catboost import CatBoostRegressor, Pool

# Generate synthetic regression data
np.random.seed(42)
data = pd.DataFrame(
    {
        "feature_1": np.random.rand(1000),
        "feature_2": np.random.rand(1000),
        "target": np.random.rand(1000) * 100,  # Target values between 0 and 100
    }
)

# Split data into train and test
train_data = data.iloc[:800]
test_data = data.iloc[800:]

train_pool = Pool(
    data=train_data[["feature_1", "feature_2"]], label=train_data["target"]
)
test_pool = Pool(
    data=test_data[["feature_1", "feature_2"]], label=test_data["target"]
)


# Define the custom loss function
def mae_log10_metric(y_true, y_pred):
    """
    Custom loss function: Mean Absolute Error on log10-transformed values
    """
    log_y_true = np.log10(y_true + 1)
    log_y_pred = np.log10(y_pred + 1)
    return np.mean(np.abs(log_y_true - log_y_pred))


# Define the custom loss class for CatBoost
class MAELog10Loss:
    def calc_ders_range(self, approxes, targets, weights):
        """
        Required method for CatBoost custom loss
        """
        return [(0.0, 0.0) for _ in range(len(approxes))]

    def evaluate(self, approxes, target, weight):
        """
        Evaluate the MAE Log10 loss
        """
        preds = approxes[0]
        loss = mae_log10_metric(target, preds)
        return loss, 0  # Loss value and standard deviation


# Train the model with adjusted subsample and bootstrap parameters
model = CatBoostRegressor(
    iterations=100,
    loss_function=MAELog10Loss(),
    eval_metric="MAPE",
    verbose=10,
    bootstrap_type="No",  # Disable bootstrap sampling
)
model.fit(train_pool, eval_set=test_pool)
