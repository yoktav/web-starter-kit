/* eslint-disable func-names */

module.exports = function(Twig) {
  Twig.extendFunction('assets', file => `../.tmp/${file}`);
};
