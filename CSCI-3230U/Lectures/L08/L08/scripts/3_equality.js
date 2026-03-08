// 3_equality.js - Shows the two forms of equality in JS
// CSCI3230U

// IS EQUAL TO (discouraged)
is_eq_to = ["0" == 0,
            "" == 0,
            null == undefined,
            0 == false,
            "" == false,
            false == 0,
            0 == 0];

console.log(is_eq_to);

// Strictly equal comparison (ENCOURAGED)
is_strictly_eq_to = ["0" === 0,
    "" === 0,
    null === undefined,
    0 === false,
    "" === false,
    false === 0,
    0 === 0];

console.log(is_strictly_eq_to);

// IS STRICTLY EQUAL TO (preferred)
is_st_eq_to = [ 0 === Number(""),
                "" === "",
                0 === 0];

console.log(is_st_eq_to);