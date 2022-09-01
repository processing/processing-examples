/**
 * Sharpen.
 *
 * This program analyzes every pixel in an image and contrasts it with the
 * neighboring pixels to sharpen the image.
 *
 * This is an example of an "image convolution" using a kernel (small matrix)
 * to analyze and transform a pixel based on the values of its neighbors.
 *
 * Sharpening is also called a "high-pass filter".  Pixels of high frequency
 * change (very differnt from neighbors) are left mostly unchanged, while
 * those with low frequency change (similar value as neighbors) are modified
 * greatly to increase contrast.
 *
 * The kernel here is a "high-boost filter", which is essentially the result
 * of subtracting low-contrast (blurred) areas from the source image - leaving
 * only the higher contrast sharp portions.
 * A more advanced version is "unsharp masking", which allows greater control
 * over the blur radius and sharpening amounts.
 *
 * For less severe sharpening, try this kernel:      [  0  -1   0 ]
 *                                                   [ -1   5  -1 ]
 *                                                   [  0  -1   0 ]
 *
 * For greater sharpening, try increasing the value of the center pixel.
 */

float[][] kernel = {{ -1, -1, -1},
                    { -1,  9, -1},
                    { -1, -1, -1}};

PImage img;

void setup() {
  size(640, 360);
  img = loadImage("moon.jpg"); // Load the original image
  noLoop();
}

void draw() {
  image(img, 0, 0); // Displays the image from point (0,0)
  img.loadPixels();

  // Create an opaque image of the same size as the original
  PImage sharpImg = createImage(img.width, img.height, RGB);

  // Loop through every pixel in the image
  for (int y = 1; y < img.height-1; y++) {   // Skip top and bottom edges
    for (int x = 1; x < img.width-1; x++) {  // Skip left and right edges
      float sumRed = 0;   // Kernel sums for this pixel
      float sumGreen = 0;
      float sumBlue = 0;
      for (int ky = -1; ky <= 1; ky++) {
        for (int kx = -1; kx <= 1; kx++) {
          // Calculate the adjacent pixel for this kernel point
          int pos = (y + ky)*img.width + (x + kx);

          // Process each channel separately, Red first.
          float valRed = red(img.pixels[pos]);
          // Multiply adjacent pixels based on the kernel values
          sumRed += kernel[ky+1][kx+1] * valRed;

          // Green
          float valGreen = green(img.pixels[pos]);
          sumGreen += kernel[ky+1][kx+1] * valGreen;

          // Blue
          float valBlue = blue(img.pixels[pos]);
          sumBlue += kernel[ky+1][kx+1] * valBlue;
        }
      }
      // For this pixel in the new image, set the output value
      // based on the sum from the kernel
      sharpImg.pixels[y*sharpImg.width + x] = color(sumRed, sumGreen, sumBlue);
    }
  }
  // State that there are changes to sharpImg.pixels[]
  sharpImg.updatePixels();

  image(sharpImg, width/2, 0); // Draw the new image
}
