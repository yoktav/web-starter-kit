import { watch, series } from 'gulp';
import browserSyncBase from 'browser-sync';

import configs from '../../configs';
import skippable from '../utils/skippable';
import { isProduction, envPath } from '../utils/env';
import html from './html';
import styles from './styles';
import scripts from './scripts';
import { syncFonts, syncImages } from './sync';
import sprite from './sprite';
import build from './build';

const browserSync = browserSyncBase.create();

function reload(cb) {
  browserSync.reload();
  cb();
}

function start() {
  // See the following link for more options
  // https://www.browsersync.io/docs/options
  browserSync.init({
    notify: false,
    logPrefix: 'WSK',
    server: [`${envPath}`],
    port: process.env.PORT,
    ghostMode: false,
    browser: process.env.BROWSER,
  });

  process.env.WATCHING = true;

  watch(
    [`${configs.paths.src}/**/*.twig`],
    { cwd: './' },
    series(html, skippable(isProduction && configs.uncssActive, styles), reload),
  );

  watch(`${configs.paths.src}/icons/*.svg`, series(sprite, html, reload));

  watch([`${configs.paths.src}/**/*.scss`], { cwd: './' }, series(styles, reload));

  watch([`${configs.paths.src}/fonts/**/*`], series(syncFonts, reload));

  watch([`${configs.paths.src}/**/*.js`], { cwd: './' }, series(scripts, reload));

  watch(`${configs.paths.src}/img/**/*`, series(syncImages, reload));
}

export default series(build, start);
