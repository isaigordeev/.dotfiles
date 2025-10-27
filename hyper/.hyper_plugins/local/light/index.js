/**
 * Simplified Hyper theme configuration with custom white color.
 * Modifications © 2025 Isai Gordeev
 * Based on original work by Andrey Polischuk <me@andrepolischuk.com> (https://andrepolischuk.com) (MIT License)
 */

'use strict';

// basic palette
const palette = {
  fg: '#383a42',
  bg: '#f2f2f2',
  red: '#e45649',
  green: '#50a14f',
  yellow: '#c18401',
  blue: '#4078f2',
  magenta: '#a626a4',
  cyan: '#0184bc',
  lightGray: '#f2f2f2',
  gray: '#696c77'
};

exports.decorateConfig = cfg => ({
  ...cfg,
  backgroundColor: cfg.enableVibrancy ? 'transparent' : palette.bg,
  foregroundColor: palette.fg,
  cursorColor: '#526eff',
  borderColor: 'transparent',
  colors: {
    black: palette.fg,
    red: palette.red,
    green: palette.green,
    yellow: palette.yellow,
    blue: palette.blue,
    magenta: palette.magenta,
    cyan: palette.cyan,
    white: palette.lightGray,
    lightBlack: palette.gray
  },
  css: `
    ${cfg.css || ''}
    .tab_tab {
      color: rgba(0, 0, 0, 0.4);
      background: rgba(50, 50, 50, 0.08);
    }
    .tab_tab.tab_active {
      font-weight: 500;
      background: transparent;
    }
    .splitpane_divider {
      background: rgba(0, 0, 0, 0.12) !important;
    }
  `,
  termCSS: `
    ${cfg.termCSS || ''}
    .cursor-node { mix-blend-mode: multiply; }
    .cursor-node[focus="false"] { opacity: 0; }
    x-row a { color: ${palette.cyan}; }
  `
});

exports.onWindow = win => {
  if (cfg.enableVibrancy) win.setVibrancy('light');
};
