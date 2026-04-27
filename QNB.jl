# Quasi-Newton Update Function

function quasi_newton_update(B, g, s, y; method::Symbol=:BFGS)
    if method == :BFGS
        # BFGS update
        ρ = 1.0 / (y' * s)
        B = (I - ρ * s * y') * B * (I - ρ * y * s') + ρ * s * s'
    elseif method == :DFP
        # DFP update
        ρ = 1.0 / (y' * s)
        B = B + (1 + (y' * B * y) / (y' * s)) * (s * s') / (y' * s) - (B * y * s' + s * y' * B) / (y' * s)
    elseif method == :SR1
        # SR1 update with positive definiteness test and line skipping
        if (y' * s) > 1e-10  # check the test condition
            B = B + (y - B * s) * (y' - s' * B) / (y' * s)
        end
    elseif method == :PSB
        # Implement PSB update logic (requires specific details)
    else
        error("Invalid method specified. Use :BFGS, :DFP, :SR1, or :PSB.")
    end
    return B
end