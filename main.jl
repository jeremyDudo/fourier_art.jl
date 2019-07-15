function dft(x)
    X = []
    N = length(x)

    for k ∈ 0:N-1
        sum = 0

        for n ∈ 0:N-1
            phi = 2*pi*k*n/N
            c = cos(phi)-sin(phi)im
            sum += x[n+1]*c
        end
        reale = real(sum)/N
        imagi = imag(sum)/N

        freq = k 
        amp = sqrt(reale^2 + imagi^2)
        phase = atan(imagi, reale)
        push!(X, [reale, imagi, freq, amp, phase])
    end

    return X
end

# !!!need to make a svg of a drawing!!!
drawing = [Dict("x"=>i*sin(i), "y"=>i^(i/100)) for i in 0:100]

path = [];
function setup()
    x = [];

    for i in 1:length(drawing)
        c = drawing[i]["x"] + drawing[i]["y"]*im
        push!(x, c)
    end
    fourierX = dft(x)
    sort!(fourierX, by = f -> f[4], rev = true)

    return fourierX
end

function epicycles(x, y, rotation, fourier)
    for i ∈ 1:length(fourier)
        prevx = x;
        prevy = y;
        freq = fourier[i][3];
        radius = fourier[i][4];
        phase = fourier[i][5];

        x += radius * cos(freq*time + phase + rotation)
        y += radius * sin(freq*time + phase + rotation)

        # drawing stuff goes here ://
    end
    return # createVector(x,y) # this is more p5.js drawing stuff
end

# drawing loop goes here
fourierX = setup()

@gif for frame ∈ 0:4*pi
    v = epicycles(width/2, height/2, 0, fourierX)
    # js magic... path.unshift(v)
    for i ∈ 1:length(path)
        # draw the vertex @ (path[i]["x"], path[i]["y"])
    end

end