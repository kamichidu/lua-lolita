local lolita= {}

function lolita.each(list, iteratee, context)
    assert(list)
    assert(iteratee)

    local fun= lolita._callable(iteratee, context)

    for k, v in pairs(list) do
        fun(v, k, list)
    end
end

lolita.for_each= lolita.each

function lolita.map(list, iteratee, context)
    assert(list)
    assert(iteratee)

    local fun= lolita._callable(iteratee, context)

    local result= {}
    for k, v in pairs(list) do
        table.insert(result, fun(v, k, list))
    end
    return result
end

lolita.collect= lolita.map

function lolita.reduce(list, iteratee, memo, context)
    assert(list)
    assert(iteratee)

    local fun= lolita._callable(iteratee, context)

    local at_first= true
    for k, v in pairs(list) do
        if at_first and not memo then
            memo= v
            at_first= false
        else
            memo= fun(memo, v, k, list)
        end
    end
    return memo
end

lolita.inject= lolita.reduce
lolita.foldl= lolita.reduce

function lolita.reduce_right(list, iteratee, memo, context)
    assert(list)
    assert(iteratee)

    local fun= lolita._callable(iteratee, context)

    local stack= {}
    for k, v in pairs(list) do
        table.insert(stack, {
            k= k,
            v= v,
        })
    end
    local at_first= true
    while #stack > 0 do
        local pair= table.remove(stack)

        if at_first and not memo then
            memo= pair.v
            at_first= false
        else
            memo= fun(memo, pair.v, pair.k, list)
        end
    end
    return memo
end

lolita.foldr= lolita.reduce_right

function lolita.find(list, predicate, context)
    assert(list)
    assert(predicate)

    local fun= lolita._callable(predicate, context)

    for k, v in pairs(list) do
        if fun(v) then
            return true, v
        end
    end
    return false, nil
end

lolita.detect= lolita.find

function lolita.filter(list, predicate, context)
    assert(list)
    assert(predicate)

    local fun= lolita._callable(predicate, context)

    local result= {}
    for k, v in pairs(list) do
        if fun(v) then
            table.insert(result, v)
        end
    end
    return result
end

lolita.select= lolita.filter

function lolita.where(list, properties)
    return lolita.filter(list, function(dict)
        for k, v in pairs(properties) do
            if not (dict[k] and dict[k] == v) then
                return false
            end
        end
        return true
    end)
end

function lolita.find_where(list, properties)
    return lolita.find(list, function(v)
        for k, v in pairs(properties) do
            if not (dict[k] and dict[k] == v) then
                return false
            end
        end
        return true
    end)
end

function lolita.reject(list, predicate, context)
    assert(list)
    assert(predicate)

    local fun= lolita._callable(predicate, context)

    local result= {}
    for k, v in pairs(list) do
        if not fun(v) then
            table.insert(result, v)
        end
    end
    return result
end

function lolita.every(list, predicate, context)
    assert(list)
    assert(predicate)

    local fun= lolita._callable(predicate, context)

    for k, v in pairs(list) do
        if not fun(v) then
            return false
        end
    end
    return true
end

lolita.all= lolita.every

function lolita.some(list, predicate, context)
    assert(list)
    assert(predicate)

    local fun= lolita._callable(predicate, context)

    for k, v in pairs(list) do
        if fun(v) then
            return true
        end
    end
    return false
end

lolita.any= lolita.some

function lolita.contains(list, value)
    return lolita.some(list, function(v)
        return v == value
    end)
end

lolita.include= lolita.some

-- TODO: _.invoke(list, methodName, *arguments)

function lolita.pluck(list, property_name)
    return lolita.map(list, function(v, k, list)
        return v[property_name]
    end)
end

-- TODO: _.max(list, [iteratee], [context])

-- TODO: _.min(list, [iteratee], [context])

-- TODO: _.sortBy(list, iteratee, [context])

-- TODO: _.groupBy(list, iteratee, [context])

-- TODO: _.indexBy(list, iteratee, [context])

-- TODO: _.countBy(list, iteratee, [context])

-- TODO: _.shuffle(list)

-- TODO: _.sample(list, [n])

-- TODO: _.toArray(list)

-- TODO: _.size(list)

-- TODO: _.partition(array, predicate)

-- TODO: _.first(array, [n])

-- TODO: _.initial(array, [n])

-- TODO: _.last(array, [n])

-- TODO: _.rest(array, [index])

-- TODO: _.compact(array)

-- TODO: _.flatten(array, [shallow])

-- TODO: _.without(array, *values)

-- TODO: _.union(*arrays)

-- TODO: _.intersection(*arrays)

-- TODO: _.difference(array, *others)

-- TODO: _.uniq(array, [isSorted], [iteratee])

-- TODO: _.zip(*arrays)

-- TODO: _.object(list, [values])

-- TODO: _.indexOf(array, value, [isSorted])

-- TODO: _.lastIndexOf(array, value, [fromIndex])

-- TODO: _.sortedIndex(list, value, [iteratee], [context])

-- TODO: _.range([start], stop, [step])

-- TODO: _.bind(function, object, *arguments)

-- TODO: _.bindAll(object, *methodNames)

-- TODO: _.partial(function, *arguments)

-- TODO: _.memoize(function, [hashFunction])

-- TODO: _.delay(function, wait, *arguments)

-- TODO: _.defer(function, *arguments)

-- TODO: _.throttle(function, wait, [options])

-- TODO: _.debounce(function, wait, [immediate])

-- TODO: _.once(function)

-- TODO: _.after(count, function)

-- TODO: _.before(count, function) 

-- TODO: _.wrap(function, wrapper)

-- TODO: _.negate(predicate)

-- TODO: _.compose(*functions)

-- TODO: _.keys(object)

-- TODO: _.values(object)

-- TODO: _.pairs(object)

-- TODO: _.invert(object)

-- TODO: _.functions(object)

-- TODO: _.extend(destination, *sources)

-- TODO: _.pick(object, *keys)

-- TODO: _.omit(object, *keys)

-- TODO: _.defaults(object, *defaults)

-- TODO: _.clone(object)

-- TODO: _.tap(object, interceptor)

-- TODO: _.has(object, key)

-- TODO: _.property(key)

-- TODO: _.matches(attrs)

-- TODO: _.isEqual(object, other)

-- TODO: _.isEmpty(object)

-- TODO: _.isElement(object)

-- TODO: _.isArray(object)

-- TODO: _.isObject(value)

-- TODO: _.isArguments(object)

-- TODO: _.isFunction(object)

-- TODO: _.isString(object)

-- TODO: _.isNumber(object)

-- TODO: _.isFinite(object)

-- TODO: _.isBoolean(object)

-- TODO: _.isDate(object)

-- TODO: _.isRegExp(object)

-- TODO: _.isNaN(object)

-- TODO: _.isNull(object)

-- TODO: _.isUndefined(value)

-- TODO: _.noConflict()

-- TODO: _.identity(value)

-- TODO: _.constant(value)

-- TODO: _.noop()

-- TODO: _.times(n, iteratee, [context])

-- TODO: _.random(min, max)

-- TODO: _.mixin(object)

-- TODO: _.iteratee(value, [context], [argCount])

-- TODO: _.uniqueId([prefix])

-- TODO: _.escape(string)

-- TODO: _.unescape(string)

-- TODO: _.result(object, property)

-- TODO: _.now()

-- TODO: _.template(templateString, [settings])

-- TODO: _.chain(obj)

-- TODO: _(obj).value()

--
-- private api
--
function lolita._callable(f, c)
    assert(f)

    if c then
        return function(...)
            return f(c, ...)
        end
    else
        return f
    end
end

return lolita
