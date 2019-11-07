import { series } from 'gulp';
import del from 'del';

import { envPath } from '../utils/env';

export function clearDist() {
  return del([`${envPath}/*`], { dot: true });
}

export default series(clearDist);
