#pragma once
#include "libs/defines.hlsl"

#include "libs/maths.hlsl"
#include "libs/fluids/water.hlsl"
#include "libs/noise/hash.hlsl"
#include "libs/lighting/lighting.hlsl"
#include "libs/texturing/samplers.hlsl"
#include "libs/texturing/uvs.hlsl"

#include "libs/programs/unreal.hlsl"

container(ShaderLibrary,

    float CheckerPattern(float2 uvs)
    {
        uvs = floor(uvs) / 2;
        float output = 2 * frac(uvs.x + uvs.y);
        return output;
    }

    float RemappedSin(float value)
    {
        return float((1.0 + sin(value)) / 2.0);
    }

)