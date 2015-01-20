
# Application connecting-dartisans

[![Build Status](https://drone.io/github.com/GeReinhart/dart-gex-common-ui-elements/status.png)](https://drone.io/github.com/GeReinhart/dart-gex-common-ui-elements/latest) [![App in QA](https://raw.githubusercontent.com/GeReinhart/app-connecting-dartisans/master/doc/images/appQa.png)](https://qa-connecting-dartisans.herokuapp.com/)




## Aim

Use cases :
-  As a Dartisan, I want to register  (Name, Level, Location as GPS point, Ready for Hire, Ready for Talks, Ready for Dojo...), so that I can be found by other Dartisans
-  As a Dartisan company, I want to register  (Name, Level, Location as GPS point, Ready to Hire...), so that I can be found by other Dartisans
-  As a Dartisan, I want to find Dartisan by different criteria : Location, Ready to Hire,  Ready for Dojo..., so that I can interact with other Dartisans

[![Story board](https://raw.githubusercontent.com/GeReinhart/app-connecting-dartisans/master/doc/story_board.png)](https://raw.githubusercontent.com/GeReinhart/app-connecting-dartisans/master/doc/story_board.png)

See the [backlog][3]

## Stack

This stack will produce resuable code :
- on client side with polymer components
- on server side with authentication service

2 applications 

### app-connecting-dartisans: 
The current application
- Client: polymer.dart
  - using [gex-common-ui-elements][4]
- Server: force on mongodb 
  - using ms-gex-auth

### ms-gex-auth: 
A micro service application to handle authentification: will store users and authorizations 
- Server: force on mongodb 


## Development guide lines
- Write reusable code
- Mobile first
- TDD 
- Continuous integration (using [drone.io][1])

## Deployement
Should be [dartvoid][2]


[1]: http://www.drone.io
[2]: http://www.dartvoid.com
[3]: https://trello.com/b/5y2Qyd8P/connecting-dartisans
[4]: https://github.com/GeReinhart/dart-gex-common-ui-elements 
