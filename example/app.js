// This is a test harness for your module
// You should do something interesting in this harness 
// to test out the module and to provide instructions 
// to users on how to use it by example.


// open a single window
var window = Ti.UI.createWindow({
	backgroundColor:'white'
});

var f = Ti.Filesystem.getFile('test.jpg');
var img = f.read.blob;
var nImgView = Ti.UI.createImageView({
  top: 0,
  width: 200,
  left: 20
});

var cImgView = Ti.UI.createImageView({
  top: 200,
  width: 100,
  left: 20
})

window.add(nImgView);
window.add(cImgView);
window.open();

// Init module
var jpgcompressor = require('com.sideshowcoder.jpgcompressor');
Ti.API.info('module is => ' + jpgcompressor);

// Test

// Set and read compress Factor
Ti.API.info('Set compress Size to 4...');
jpgcompressor.setCompressSize(4);
Ti.API.info('Compress Size: ' + jpgcompressor.compressSize);

// Compress an image
var cImg = jpgcompressor.compress(img);
nImgView.setImage(img);
cImgView.setImage(cImg);







