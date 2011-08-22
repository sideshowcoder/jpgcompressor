// This is a test harness for your module
// You should do something interesting in this harness 
// to test out the module and to provide instructions 
// to users on how to use it by example.


// open a single window
var window = Ti.UI.createWindow({
	backgroundColor:'black'
});

// Load images
var images = []
var f144 = Ti.Filesystem.getFile('144K.JPG');
images.push(f144.read.blob);
var f1500 = Ti.Filesystem.getFile('1500K.JPG');
images.push(f1500.read.blob);
var f191 = Ti.Filesystem.getFile('191K.JPG');
images.push(f191.read.blob);
var f324 = Ti.Filesystem.getFile('324K.JPG');
images.push(f324.read.blob);

var iv = Ti.UI.createImageView({
  top: 30,
  left: 0
});

var btn = Ti.UI.createButton({
  top: 0,
  height: 30,
  title: 'Press to Switch Images',
  left: 0
});

window.add(iv);
window.add(btn);
window.open();

// Init module
var jpgcompressor = require('com.sideshowcoder.jpgcompressor');
Ti.API.info('module is => ' + jpgcompressor);

// Set and read compress Factor to 100Kb
jpgcompressor.setCompressSize(102400);
jpgcompressor.setWorstCompressQuality(0.65);

var curr = 0;
var names = ['144K', '1500K', '191K', '324K'];

btn.addEventListener('click', function(){
  Ti.API.log(names[curr]);
  cImage = jpgcompressor.scale(images[curr], 960, 960);
  iv.setImage(jpgcompressor.compress(cImage));
  curr = (curr + 1) % 4;
});







