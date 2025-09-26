

async → Future<Something>
async → Future<void> if you don’t return anything

//define an async function
Future<type of Return - can be vod> nameOfFunction(inputs) async {
    //implementation
}

//use/call the function
var myVal = await nameOfFunction(inputs)

nameOfFunction(inputs).then{}

var myVal = nameOfFunction(inputs)
myVal.then{}