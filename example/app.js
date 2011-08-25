// This is a test harness for your module
// You should do something interesting in this harness 
// to test out the module and to provide instructions 
// to users on how to use it by example.


// open a single window
var window = Ti.UI.createWindow({
	backgroundColor:'black'
});

// Load images
var images = [];
var names = ['150k.jpg', '1m.jpg', '200k.jpg', '400k.jpg'];
var imgNames = ['150k_out.jpg', '1m_out.jpg', '200k_out.jpg', '400k_out.jpg'];
var curr = 0;

names.forEach(function(el, idx, arr){
  var file = Ti.Filesystem.getFile(el);
  images.push(file.read.blob);
});

var iv = Ti.UI.createImageView({
  top: 60,
  left: 0
});

var picBtn = Ti.UI.createButton({
  top: 0,
  height: 30,
  title: 'Press to Switch Images',
  left: 0
});

var fileBtn = Ti.UI.createButton({
  top: 30,
  height: 30,
  title: 'Press to output file images',
  left: 0
});


window.add(iv);
window.add(picBtn);
window.add(fileBtn);
window.open();

// Init module
var jpgcompressor = require('com.sideshowcoder.jpgcompressor');
Ti.API.info('module is => ' + jpgcompressor);

// Set and read compress Factor to 100Kb
jpgcompressor.setCompressSize(102400);
jpgcompressor.setWorstCompressQuality(0.65);

picBtn.addEventListener('click', function(){
  Ti.API.info("Name " + names[curr]);
  Ti.API.info("Length " + images[curr].length);
  cImage = jpgcompressor.scale(images[curr], 960, 960);
  iv.setImage(jpgcompressor.compress(cImage));
  curr = (curr + 1) % 4;
});

fileBtn.addEventListener('click', function(){
  var imgFilePath, imgFile;
  Ti.API.info("Image output name " + imgNames[curr]);
  Ti.API.info("Length " + images[curr].length);
  cImage = jpgcompressor.scale(images[curr], 960, 960);
  imgFilePath = jpgcompressor.compress(cImage, imgNames[curr]);
  imgFile = Ti.Filesystem.getFile(imgFilePath);
  Ti.API.info("File Size " + imgFile.read.blob.length);  
  iv.setImage(imgFile.read.blob);
  curr = (curr + 1) % 4;  
});






