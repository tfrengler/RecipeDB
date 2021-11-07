"use strict";

// Creates an enum from an array of strings, which is an immutable "list" of predefined options
// Each entry is a symbol-type and therefore guaranteed to be unique

export class Enum
{
    constructor(arrayOfOptions)
    {
        arrayOfOptions.forEach(option=> {
            if (typeof(option) != typeof(""))
                throw new Error("Error creating enum. Option is not a string value: " + option);

            this[option] = Symbol(option);
        });

        return new Proxy(Object.freeze(this), EnumHandler);
    }

    has(value = "UNKNOWN")
    {
        return Object.values(this).indexOf(value) > -1;
    }

    getName(value)
    {
        return this[value].description;
    }

    validate(value = "UNKNOWN")
    {
        if (Object.values(this).indexOf(value) == -1)
            throw new Error("Option does not exist in enum: " + value);
    }
}

const EnumHandler = Object.create(null);

EnumHandler.get = function(target, property)
{
    if (!target[property])
        throw new Error("Constant not found in enum: " + property);

    if (typeof property === typeof Function)
        return target[property].bind(target);

    return Reflect.get(target, property);
}

EnumHandler.set = ()=> { throw new Error("Illegal operation on enum type") },
EnumHandler.defineProperty = () => { throw new Error("Illegal operation on enum type") },
EnumHandler.deleteProperty = () => { throw new Error("Illegal operation on enum type") },
EnumHandler.setPrototypeOf = () => { throw new Error("Illegal operation on enum type") }

Object.freeze(EnumHandler);