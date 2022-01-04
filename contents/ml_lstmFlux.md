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
    ŷ = Flux.stack(out, 3)[:, :, end]
    Flux.mse(y, ŷ)
end
```

- Multiple mini-batches

Then defining our mini-batch function is straightforward:

```
using Base.Iterators: partition
```

Taking into account the input and the target (sequence-to-one), namely

```
xraw = rand(Float32, nfeatures, nsamples, seqlen)
xdata = [xraw[:, :, t] for t in 1:seqlen]
ydata = rand(Float32, nsamples)
```

the mini-batch process can be done with:

```jl
s = """
    function rawBatch(xdata, ydata; batchsize=2, partial=false)
        minibatch = partition(1:size(xdata)[2], batchsize)
        seqlen = size(xdata)[3]
        lastmb(p) = partial ? true : size(p)[1] < batchsize
        xbatch = [[xdata[:,p, t] for t in 1:seqlen] for p in minibatch if lastmb(p)]
        ybatch = [ydata[p] for p in minibatch]
        return (xbatch, ybatch)
    end
"""
sc(s)
```

using this format the `Flux.train!` function will iterate over each mini-batch.

- Training loop
