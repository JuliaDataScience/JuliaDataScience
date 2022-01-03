function lstmSequence()
    seed!(123)
    nfeatures, out = 3, 1
    seqLen = 4
    m = Chain(LSTM(nfeatures, 2), Dense(2, out))
    xSeq = rand(Float32, nfeatures, seqLen)
    xtSeq = [xSeq[:, t] for t in 1:seqLen]
    return [m(x) for x in xtSeq]
end

function lstmSamplesSequence()
    seed!(123)
    nfeatures, out = 3, 1
    seqLen = 4
    nsamples = 5
    m = Chain(LSTM(nfeatures, 2), Dense(2, out))
    xSeq = rand(Float32, nfeatures, nsamples, seqLen)
    xtSeq = [xSeq[:, :, t] for t in 1:seqLen]
    return [m(x) for x in xtSeq]
end
