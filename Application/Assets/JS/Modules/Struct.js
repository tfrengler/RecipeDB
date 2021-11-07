"use strict";

// A class representing a structure designed to only hold data, and no methods
// Attempts to retrieve any methods defined on "object" will return null
// ReadOnly Structs can - as the name suggests - not have their values mutated

export class Struct
{
    constructor(object)
    {
        return new Proxy(object, StructHandler);
    }
}

export class ReadOnlyStruct
{
    constructor(object)
    {
        return new Proxy(Object.freeze(object), ReadOnlyStructHandler);
    }
}

const StructHandler = Object.create(null);
const ReadOnlyStructHandler = Object.create(null);

const get = function(target, property, receiver)
{
    if (!target[property])
        throw new Error("No such property in struct: " + property);

    if (typeof(target[property]) === typeof(Function))
        return null;

    return Reflect.get(target, property, receiver);
}

const set = function(target, property, receiver)
{
    if (!target[property])
        throw new Error("No such property in struct: " + property);

    return Reflect.set(target, property, receiver);
}

const readonlySet = () => { throw new Error("Struct is read-only") };
const defineProperty = () => { throw new Error("Illegal operation on struct"); }
const deleteProperty = () => { throw new Error("Illegal operation on struct"); }
const setPrototypeOf = () => { throw new Error("Illegal operation on struct") };

StructHandler.defineProperty = defineProperty;
StructHandler.deleteProperty = deleteProperty;
StructHandler.get = get;
StructHandler.set = set;
StructHandler.setPrototypeOf = setPrototypeOf;

ReadOnlyStructHandler.defineProperty = defineProperty;
ReadOnlyStructHandler.deleteProperty = deleteProperty;
ReadOnlyStructHandler.get = get;
ReadOnlyStructHandler.set = readonlySet;
ReadOnlyStructHandler.setPrototypeOf = setPrototypeOf;