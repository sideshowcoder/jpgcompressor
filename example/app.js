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
});

var c2ImgView = Ti.UI.createImageView({
  top: 300,
  width: 100,
  left: 20
});


window.add(nImgView);
window.add(cImgView);
window.add(c2ImgView);
window.open();

// Init module
var jpgcompressor = require('com.sideshowcoder.jpgcompressor');
Ti.API.info('module is => ' + jpgcompressor);

// Test

// Set and read compress Factor
Ti.API.info('Set compress Size to 1000...');
jpgcompressor.setCompressSize(1000);
Ti.API.info('Compress Size: ' + jpgcompressor.compressSize);
Ti.API.info('Unset worst quality: ' + jpgcompressor.worstCompressQuality);

// Compress an image
var cImg = jpgcompressor.compress(img);
jpgcompressor.setCompressSize(100);
Ti.API.info('Set compress Size to 100...');
jpgcompressor.setWorstCompressQuality(0.2);
Ti.API.info('Compress Size: ' + jpgcompressor.compressSize);
Ti.API.info('Unset worst quality: ' + jpgcompressor.worstCompressQuality);
var c2Img = jpgcompressor.compress(img);
nImgView.setImage(img);
cImgView.setImage(cImg);
c2ImgView.setImage(c2Img);






