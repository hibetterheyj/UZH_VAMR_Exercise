## Exercise1 - Augmented reality wireframe cube

### How to run?
1. download the zip file ([Exercise 01](http://rpg.ifi.uzh.ch/docs/teaching/2020/exercise1.zip)) and extract `data/` folder here

2. run the code

   ```
   ex1_draw_pts_cube_img.m
   ex2_draw_cube_video.m
   ex3_draw_pts_distored_img.m
   ex3_undistort_image.m
   ```

### TODO

- Part 1: Drawing a cube on the undistorted images
  - [x] Writing and testing the projection function
  - [x] Drawing the cube
  - [x] (Optional) Generating a video from the images
- Part 2: Accounting for lens distortion
  - [x] Writing and testing the projection function with lens distortion
  - [ ] Undistorting the images :construction:

### Misc.

- [Rodrigues' rotation formula](https://en.wikipedia.org/wiki/Rodrigues'_rotation_formula) allows to convert [Axis–angle representation](https://en.wikipedia.org/wiki/Axis%E2%80%93angle_representation) to a rotation matrix

- [cv::Rodrigues](https://docs.opencv.org/3.4/d9/d0c/group__calib3d.html#ga61585db663d9da06b68e70cfbf6a1eac)

  - given vecter
    $$
    \begin{array}{l} \theta \leftarrow norm(r) \\ r \leftarrow r/ \theta \\ R = \cos(\theta) I + (1- \cos{\theta} ) r r^T + \sin(\theta) \vecthreethree{0}{-r_z}{r_y}{r_z}{0}{-r_x}{-r_y}{r_x}{0} \end{array}
    $$

  - inverse operation
    $$
    \sin ( \theta ) \vecthreethree{0}{-r_z}{r_y}{r_z}{0}{-r_x}{-r_y}{r_x}{0} = \frac{R - R^T}{2}
    $$

- [axang2rotm](https://www.mathworks.com/help/robotics/ref/axang2rotm.html)--Convert axis-angle rotation to rotation matrix

