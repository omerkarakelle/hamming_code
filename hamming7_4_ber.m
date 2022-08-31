genmat = [1 1 1 0 0 0 0; 1 0 0 1 1 0 0; 0 1 0 1 0 1 0; 1 1 0 1 0 0 1]
parity_check = [1 0 1 0 1 0 1; 0 1 1 0 0 1 1; 0 0 0 1 1 1 1]
r = [0 0 1 0 0 0 0; 0 0 0 0 1 0 0; 0 0 0 0 0 1 0; 0 0 0 0 0 0 1]

totalerror = zeros(10, 1);

for p = 1:10
    for i = 1:10000
        data = randi([0 1], 1, 4); %input
        codeword = mod(data * genmat, 2);
        rcvd_code = ft_channel(codeword, p*0.05); %Binary Symmetrical Channel
        syndrome = mod(rcvd_code * parity_check.', 2);
        error = zeros(1,7);
        if not(bi2de(syndrome) == 0)
            error(bi2de(syndrome)) = 1;
        end
        x = mod(rcvd_code + error, 2);
        output = r * x.';
        totalerror(p) = totalerror(p) + biterr(data, output.');
    end
end

p = (1:1:10);
figure;
plot(p*0.05, totalerror/40000, 'LineWidth', 2); %totalerror / 4 x 10000 = 40.000 bits of data

function rcvd_code = ft_channel(code, p) 
    for i = 1:length(code)
        j = rand;
        if j > p
            rcvd_code(i) = code(i);
        else
            rcvd_code(i) = mod(code(i) + 1,2);
        end
    end
end
