/**
*  @file main.cpp
*  @author Adam McCann (mccann232@gmail.com)
*  @brief practice command line opencv program
*/
#include <stdio.h>

#include <opencv2/core/utility.hpp>
#include <opencv2/imgproc.hpp>
#include <opencv2/imgcodecs.hpp>
#include <opencv2/highgui.hpp>

#include "version.h"

using namespace cv;
using namespace std;

int edgeThresh = 1;
Mat image, gray, edge, cedge;

static void help()
{
    printf("\nThis sample demonstrates Canny edge detection\n"
           "Call:\n"
           "    starter [image_name -- Default is fruits.jpg]\n\n");
}

const char* keys =
{
    "{help h||}{@image |fruits.jpg|input image name}"
};

int main( int argc, const char** argv )
{
    CommandLineParser parser(argc, argv, keys);
    if (parser.has("help"))
    {
        help();
        return 0;
    }
    string filename = parser.get<string>(0);
    image = imread(filename, 1);
    if(image.empty())
    {
        printf("Cannot read image file: %s\n", filename.c_str());
        help();
        return -1;
    }
    cedge.create(image.size(), image.type());
    cvtColor(image, gray, COLOR_BGR2GRAY);

    // Run the edge detector on grayscale
    blur(gray, edge, Size(3,3));
    Canny(edge, edge, edgeThresh, edgeThresh*3, 3);
    cedge = Scalar::all(0);
    image.copyTo(cedge, edge);

    imwrite("start.jpg", cedge);
    return 0;
}
