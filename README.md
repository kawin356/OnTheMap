# OnTheMap

This is result of study at Udacity in iOS nanodegree. Poject OnTheMap is about Udacity student location.
It can pin new student location. use API of udacity (API for Project students)

## API
get 100 student detail include location

### GET
`https://onthemap-api.udacity.com/v1/StudentLocation` and add `order=-updatedAt` for get new result

```
struct StudentLocation: Codable {
    let results : [Student]
}

struct Student: Codable {
    let firstName: String
    let lastName: String
    let longitude: Double
    let latitude: Double
    let mapString: String
    let mediaURL: String
    let uniqueKey: String
    let objectId: String
    let createdAt: String
    let updatedAt: String
}
```

and **GET** user detail `https://onthemap-api.udacity.com/v1/users/<user_id>`

### POST

post login to Udacity `https://onthemap-api.udacity.com/v1/session`


```
Request
struct LoginRequest: Codable {
    let username: String
    let password: String
}

This is Response when you sent Request
struct LoginResponse: Codable {
    
    struct Account: Codable {
        let registered: Bool
        let key: String
    }

    struct Session: Codable {
        let id: String
        let expiration: String
    }
    
    let account: Account
    let session: Session
}
```

post add new student 

`https://onthemap-api.udacity.com/v1/StudentLocation`

```
struct StudentLocationRequest: Codable {
    let uniqueKey: String
    let firstName: String
    let lastName: String
    let mapString: String
    let mediaURL: String
    let latitude: Double
    let longitude: Double
}
```

### PUT
update student detail user Struct same as POST new student


### Delete
delete session when you have to logout

`https://onthemap-api.udacity.com/v1/session`

## ScreenShot

### Login
![](/ScreenShot/login.gif)

### Link URL
![](/ScreenShot/linkURL.gif)

### Pin Location
![](/ScreenShot/owLocation.gif)

### Login Error Hanldling
![](/ScreenShot/loginfail.gif)

## License

MIT License

Copyright (c) 2020 Kittikawin S

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
