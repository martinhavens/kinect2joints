# kinect2joints

An Introduction to Robotics team project where the demonstration of teleoperation of a robotic arm with a consumer Xbox Kinect provides practical programming experience prior to graduating from UNorth Florida in Mechanical Engineering. It is with pleasure that this code is shared.

requires a Kinect version 2 and adapter cables

The program records shoulder, elbow, and joint movements between triggers and calculates the joint space angles from these lines vectors. This data is passed into CoppeliaSim software via a MATLAB API server.
![jointpic](https://user-images.githubusercontent.com/77357736/112859927-54092b00-9081-11eb-9b95-0717876bab66.png)

![image](https://user-images.githubusercontent.com/77357736/113426670-cccdf700-93a1-11eb-997b-be21d4a97db7.png)


### Using V1.5 data:

_v1_5data_figure.fig_ is a MATLAB visual of the body motion tracked for the 1.5 data

_v1_5joint_vector_and_angle_data.mat_ provides JointPositions variable, vectors between joints, and 6 angles (3 for each joint)

Where theta is x-y, phi is y-z, psi is z-x as seen in _kinect2joints1v5.m_

## V2.0 will include live angle representation in MATLAB transferred to CoppeliaSim via API server.
