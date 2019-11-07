import { series, parallel } from 'gulp';
import c from 'ansi-colors';

import notifier from '../utils/notifier';
import { clearDist } from './clear';
import html from './html';
import scripts from './scripts';
import styles from './styles';
import copy from './copy';
import sprite from './sprite';

function completed(cb) {
  notifier('Build işlemi başarılı bir şekilde tamamlandı.');

  // eslint-disable-next-line no-console
  console.log(
    c.green(
      '\n==============================================\n' +
        'Build işlemi başarılı bir şekilde tamamlandı.' +
        '\n==============================================\n',
    ),
  );
  cb();
}

export default series(
  clearDist,
  sprite,
  parallel(html, scripts, copy),
 styles,
  completed,
);
