import del from 'del';

import configs from '../../configs';
import { isProduction } from '../utils/parseArguments';

const envPath = isProduction ? configs.paths.dist : configs.paths.dev;

export function cleanDist() {
  return del([`${envPath}/*`], { dot: true });
}

export function cleanImgCache() {
  return del(['.tmp/js/*'], { dot: true });
}

export function cleanTempJs() {
  return del(['.tmp/js/*'], { dot: true });
}

export function cleanDeployFolder() {
  return del([`${configs.paths.deploy}/*`], { dot: true, force: true });
}

export function cleanSprite() {
  return del(['.tmp/img/sprite.svg'], { dot: true });
}

export default {
  dist: cleanDist,
  imgCache: cleanImgCache,
  tempJs: cleanTempJs,
  deployFolder: cleanDeployFolder,
  sprite: cleanSprite,
};