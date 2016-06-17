const configs = {
  info: {
    name: 'Project-Name',
    version: '1.0.0',
    description: 'Project Desc',
    author: {
      name: 'Atolye15',
      email: 'hello@atolye15.com',
      url: 'http://www.atolye15.com'
    }
  },
  lint: {
    scripts: true,
    styles: true
  },
  paths: {
    src: 'src',
    dev: 'dev',
    dist: 'dist',
    deploy: '../web/assets',
    assets: {
      js: 'js',
      css: 'css',
      img: 'img',
      fonts: 'css/fonts',
      vendors: 'js/vendors'
    }
  },
  browserSync: {
    notify: false,
    // Customize the Browsersync console logging prefix
    logPrefix: 'WSK',
    // Proxy an EXISTING vhost. Browsersync will wrap your vhost with a proxy URL to view your site
    proxy: 'localhost/web-starter-kit/',
    // Disable open automatically when Browsersync starts.
    open: false,
    // Allow scroll syncing across breakpoints
    // scrollElementMapping: ['main', '.mdl-layout'],
    // Run as an https by uncommenting 'https: true'
    // Note: this uses an unsigned certificate which on first access
    //       will present a certificate warning in the browser.
    // https: true,
    // server: [configs.paths.dev],
    port: 3000
  },
  styleGuide: {
    source: [
      'src/sass'
    ],
    destination: 'styleguide/',
    // The css and js paths are URLs, like '/misc/jquery.js'.
    // The following paths are relative to the generated style guide.
    css: [
      '../dev/css/main.css'
    ],
    js: [],
    homepage: 'styleguide.md',
    template: 'styleguide/_config/templates/kss-node-template'
  },
  jsFiles: ['main.js'],
  libFiles: []
};

module.exports = configs;
