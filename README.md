
# Application connecting-dartisans

[![Build Status](https://drone.io/github.com/GeReinhart/app-connecting-dartisans/status.png)](https://drone.io/github.com/GeReinhart/app-connecting-dartisans/latest)[ ![App in QA](https://raw.githubusercontent.com/GeReinhart/app-connecting-dartisans/master/doc/images/appQa.png)](https://qa-connecting-dartisans.herokuapp.com/)

Will be available soon on production at http://connecting.dartisans.net

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
  - using [gex-webapp-kit][4]
- Server: redstone on mongodb 
  - using [gex-webapp-kit][4]


## Development guide lines
- Write reusable code
- Mobile first
- TDD 
- Continuous integration (using [drone.io][1])

## Deployement
Should be [dartvoid][2]


[1]: https://drone.io/github.com/GeReinhart/dapp-connecting-dartisans/latest
[2]: http://www.dartvoid.com
[3]: https://trello.com/b/5y2Qyd8P/connecting-dartisans
[4]: https://github.com/GeReinhart/dart-gex-webapp-kit-client 
