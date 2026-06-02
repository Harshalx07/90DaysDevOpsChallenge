#!/bin/bash

local_var_demo() {
    local name="Harshal"
    echo "Inside function: $name"
}

regular_var_demo() {
    city="Pune"
    echo "Inside function: $city"
}

local_var_demo

echo "Outside function local variable: ${name:-Not Available}"

regular_var_demo

echo "Outside function regular variable: $city"