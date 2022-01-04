function lstmSequence()
    seed!(123)
    nfeatures, out = 3, 1
    seqlen = 4
    xSeq = rand(Float32, nfeatures, seqlen)
    xtSeq = [xSeq[:, t] for t in 1:seqlen]
    # model
    m = Chain(LSTM(nfeatures, 2), Dense(2, out))
    return [m(x) for x in xtSeq]
end

function lstmSamplesSequence()
    seed!(123)
    nfeatures, out = 3, 1
    seqlen = 4
    nsamples = 5
    xSeq = rand(Float32, nfeatures, nsamples, seqlen)
    xtSeq = [xSeq[:, :, t] for t in 1:seqlen]
    # model
    m = Chain(LSTM(nfeatures, 2), Dense(2, out))
    return [m(x) for x in xtSeq]
end

function rawBatch(xdata, ydata; batchsize=2, partial=false)
    minibatch = partition(1:size(xdata)[2], batchsize)
    seqlen = size(xdata)[3]
    lastmb(p) = partial ? true : size(p)[1] < batchsize
    xbatch = [[xdata[:,p, t] for t in 1:seqlen] for p in minibatch if lastmb(p)]
    ybatch = [ydata[p] for p in minibatch]
    return (xbatch, ybatch)
end
