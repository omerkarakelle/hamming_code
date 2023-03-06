data = [1 0 0 1] %input
n = 7 %input
k = 4 %input

m = log2(n + 1);

if not(k == length(data))
    fprintf("Error! Length of the input and the value of k does not match.\n")
    return
end
if not(k == power(2, m) - m - 1) 
    fprintf("Error! Invalid values of k and/or n\n")
    return
end

A = ft_matrix(n,k); 

genmat = [eye(k) A];
par_check = [A.' eye(n - k)];
r = [eye(k) zeros(k, n - k)];

codeword = mod(data * genmat, 2);

function y = is_power_of_2(x)
    y = 0;
    i = 0;
    while pow2(i) <= x 
        if pow2(i) == x
            y = 1;
            return
        end
        i = i + 1;
    end
end

function A = ft_matrix(n, k) %this function generates a generator matrix
    A = zeros(k, n - k);
    t = 1;
    for i = 1:(n - k)*k
        while is_power_of_2(t) == 1
            t = t + 1;
        end
        x = de2bi(t);
        if fix((i-1) / k) + 1 > length(x)
            A(i) = 0;
        else
            A(i) = x(fix((i-1) / k) + 1);
        end
        if t == n
            t = 1;
        else
            t = t + 1;
        end
    end
end
