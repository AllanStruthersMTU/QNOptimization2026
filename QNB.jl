function QNB(B, s, y, method)    # B: current approximation to the Hessian, s: step vector, y: gradient difference, method: 'SR1', 'DFP', 'BFGS', or 'PSB'
    if method == "SR1"
        if (y - B*s) * (y - B*s)' < 1e-10
            println("Skipping update due to near-zero value.")
            return
        end
        B += (y - B*s) * (y - B*s)' / (s' * (y - B*s))
    elseif method == "DFP"
        B += (s*s') / (s' * y) - (B * y * y' * B) / (y' * B * y)
    elseif method == "BFGS"
        B += (s*s') / (s' * y) - (B * y * y' * B) / (y' * B * y)
    elseif method == "PSB"
        B += (y - B*s) * (y - B*s)' / (s' * s) - (s' * (y - B*s) * s * s') / (s' * s)^2
    else
        error("Invalid method. Use 'SR1', 'DFP', 'BFGS', or 'PSB'.")
    end
    return B
end