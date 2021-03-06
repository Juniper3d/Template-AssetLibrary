#pragma once
#include "defines.hlsl"


container(Maths,

    float2 LinearSine(in float value)
    {
        float output = 0.0;

        const float frac_val = frac(value);
        const float a = (2.0 * frac_val);
        const float b = (2.0 * (1.0 - frac_val));
        output = lerp(a, b, floor(a));

        return output;
    }

    float CheapContrast(const float value, const float contrast)
    {
        return saturate(lerp(0 - contrast, 1 + contrast, value));
    }

)
