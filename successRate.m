function res = successRate(masses,length)
    counter = 0;
    for i = 1:100
        test = simulateBolasMarkII(masses,length, i / 5);
        if test == 1
            counter = counter + 1;
        end
    end
    res = counter * 0.01;
end