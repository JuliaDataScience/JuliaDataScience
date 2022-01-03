## LSTM {#sec:ml_lstmFlux}

DRAFT:

Recurrent models such as LSTMs are also of course possible with Flux.
Before going into the internals or your know them already we can get familiar with the syntax and start with our first working example.

The Long Short Term Memory (LSTM) recurrent layer takes as input 2 integers indicating the input(features) and the output size arrays.

```
m = LSTM(in::Integer, out::Integer)
```

Working with a simple recurrent LSTM layer can be done as follows

```
using Flux
```

```jl
m = LSTM(3,2)
```

So that if we have the input

```jl
seed!(123)
s = rand(Float32, 3)
```

and we use `m`, it would give us:

```jl
m(s)
```

Knowing how this building block works allows us to build more complicated architectures as the following:

```jl
seed!(123)
m = Chain(LSTM(3,2), Dense(2,1))
```

where now we have 3 input features and the output(target) is just one value.

Now, it comes probably the most important part of using LSTMs. In order to work with them effectively we need to know how sequences of data are to be handle.

- Time steps (sequence length)

```jl
@sco JDS.lstmSequence()
```

This will correspond to just one sample with _3 features_ and a sequence length of 4.

- Number of samples
More samples are added as follows:

```jl
@sco JDS.lstmSamplesSequence()
```

Taking the last time state from all samples

```
out = lstmSamplesSequence()
```

can be done with

```jl
s = """
    out = lstmSamplesSequence() # hide
    ŷ = Flux.stack(out, 3)[:, :, end]
    """
sco(s)
```

Warning: `Flux.reset!(m)` after each batch pass. Also important when defining the loss function. Namely

```
function loss(x,y)
    Flux.reset!(model)
    ŷ = Flux.stack(model.(x), 3)[:, :, end]
    Flux.mse(y, ŷ)
end
```

- Multiple Batches

- Training loop
