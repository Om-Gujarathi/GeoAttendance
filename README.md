## Overview

GeoAttedance is a mobile application built using the Flutter framework. This application allows users to mark their attendance for a specific class or event, view their attendance history, and view attendance statistics for a class or event.

The application has two ways to login, one for students and one for educators. The student login allows students to mark their attendance for a specific class or event and view their attendance history. This application allows students to mark their attendance for a specific class or event based on their proximity to the educator's GPS location and when the educator has started the attendance. The educator login allows educators to make new classes, view attendance statistics for a class or event and start/stop the attendance.

Overall, this application is a useful tool for students, teachers, or anyone else who needs to keep track of attendance for a class or event. The separate login for students and educators ensures that the users have access to only the relevant information and functionality, making it easy to use, and provides real-time information about attendance statistics. The geolocation feature ensures that the attendance is marked only when the student is physically present in the class.

## Getting Started

1.  Clone the repository to your local machine : 

    git clone https://github.com/Om-Gujarathi/Attendance-System-Flutter.git
    
2.  Navigate to the project directory :

    cd Attendance-System-Flutter

3.  Install the necessary dependencies :

     flutter pub get

4. Run the app on an emulator or connected device :

    flutter run

## Screenshots/Demo


1. Student Login -

https://user-images.githubusercontent.com/98649066/214312171-3f5dab46-ba5b-41ad-9a69-da9818811c89.mp4

2. Admin Login - 

https://user-images.githubusercontent.com/98649066/214312225-639ba714-0f3c-49d9-abe0-2865b23c1334.mp4


## Built With

-   [Flutter](https://flutter.dev/) - The mobile app development framework used
-   [Node.js](https://nodejs.org/) - The JavaScript runtime used for the server-side logic and REST API's
-   [MongoDB](https://www.mongodb.com/) - The NoSQL database used for storing the attendance data
-   [Render](https://render.com/) - The platform used for hosting the Node.js server and REST API's

The Flutter framework was used to build the front-end of the application and provide a seamless user experience. The Node.js runtime was used for the server-side logic to handle the communication with the database and provide a secure and efficient way to handle the attendance data. We have also written RESTful APIs in Node.js that handle the communication between the mobile app and the server. These REST APIs were hosted on Render, a platform that provides easy and convenient hosting solutions for Node.js applications. The MongoDB database was used to store the attendance data and provide a flexible and scalable solution for data management.


## API Reference
All the server side code is available in this repository.([Server Code Link](https://github.com/Om-Gujarathi/Edi-Server))


## Authors
-   [Om Gujarathi](https://github.com/Om-Gujarathi) 
-   [Sanskar Gundecha](https://github.com/SanskarG83) 
