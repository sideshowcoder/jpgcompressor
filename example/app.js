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
var cImgView = Ti.UI.createImageView({
  top: 100,
  width: 50,
  left: 20
});

var c2ImgView = Ti.UI.createImageView({
  top: 200,
  width: 50,
  left: 20
});

var sImgView = Ti.UI.createImageView({
	top: 300,
	width: 100,
	left: 20
});

window.add(cImgView);
window.add(c2ImgView);
window.add(sImgView);
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
cImgView.setImage(cImg);
c2ImgView.setImage(c2Img);

// Scale image
Ti.API.info('Image width: ' + img.width + ' heigth: ' + img.height );
var sImg = jpgcompressor.scale(img, 100, 100);
Ti.API.info('Scaled image width: ' + sImg.width + ' heigth: ' + sImg.height );
sImgView.setImage(sImg);







