# Application connecting-dartisans

## Aim

Use cases :
-  As a Dartisan, I want to register  (Name, Level, Location as GPS point, Ready for Hire, Ready for Talks, Ready for Dojo...), so that I can be found by other Dartisans
-  As a Dartisan company, I want to register  (Name, Level, Location as GPS point, Ready to Hire...), so that I can be found by other Dartisans
-  As a Dartisan, I want to find Dartisan by different criteria : Location, Ready to Hire,  Ready for Dojo..., so that I can interact with other Dartisans

## Stack

2 applications 

### app-find-dartisans: 
The current application
- Client: polymer.dart
- Server: force on mongodb 
  - using ms-gex-auth

### ms-gex-auth: 
A micro service application to handle authentification: will store users and authorizations 
- Server: force on mongodb 

## Development guide lines
- TDD 
- Continuous integration (using [drone.io][1])

## Deployement
Should be [dartvoid][2]


[1]: http://www.drone.io
[2]: http://www.dartvoid.com
