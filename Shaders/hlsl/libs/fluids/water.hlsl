#pragma once
#include "../defines.hlsl"


// Gerstner Wave function
// return.xyx is the Gerstner Vector
// return.w is the amplitude mask

container(Water,

    float4 SampleFlowMap(in Texture2D texture_, in Texture2D breakup_texture, in float2 flow_vector, in float time, in float2 uvs)
    {
        /*float2 breakup_uvs = frac(uvs + (time * 0.02));
        float4 breakup_sample = Texture2DSample(breakup_texture, View.MaterialTextureBilinearWrapedSampler, breakup_uvs); // TODO: Sampler
        float breakup_value_1 = frac((breakup_sample.x * 0.25) + time);
        float breakup_value_2 = frac((breakup_sample.x * 0.25) + time) - 0.5;
        float2 uv1 = uvs + (flow_vector * breakup_value_1);
        float2 uv2 = uvs + (flow_vector * breakup_value_2) + 0.5;

        float4 sample_a = Texture2DSample(texture, View.MaterialTextureBilinearWrapedSampler, uv1);
        float4 sample_b = Texture2DSample(texture, View.MaterialTextureBilinearWrapedSampler, uv2);
        const float sin_value = Maths.LinearSine(breakup_value_1);
        return lerp(sample_a, sample_b, sin_value);*/
        // TODO:
        return 0.0;
    }

    float4 GerstnerWave(in float3 world_pos, in float wind_direction, in float time, in float wavelength, in float phase, in float steepness, in float amplitude)
    {
        float4 output = float4(0.0, 0.0, 0.0, 0.0);
        float3 wind_vec = float3(cos(wind_direction), sin(wind_direction), 0.0);

        float pW = 2 / wavelength;
        float wSpd = (time * phase * pW);
        float wDot = (dot(world_pos.xy, normalize(wind_vec).xy) * pW) + wSpd;
        float calcSteepness = amplitude * (steepness / (amplitude * pW * pow(6.283, 2)));

        output.x = cos(wDot) * wind_vec.x * calcSteepness;  //X
        output.y = cos(wDot) * wind_vec.y * calcSteepness;  //Y
        output.z = sin(wDot) * amplitude;                  //Z
        output.w = amplitude * pW * pW * phase;            //W

        return output;
    }

    float4 GerstnerWaves(in float num_waves, in float3 world_pos, in float wind_direction, in float time, in float wavelength, in float phase, in float steepness, in float amplitude)
    {
        float4 output = float4(0.0, 0.0, 0.0, 0.0);
        float fract = 1.0 / num_waves;
        float dir = 1.0;

        for(int i = 1; i <= num_waves; i++)
        {
            //world_pos = world_pos * 2.0;
            wavelength = wavelength / 2.0;
            phase = phase / 2.0;
            //steepness = steepness / 2.0;
            amplitude = amplitude / 2.0;
            output += GerstnerWave(world_pos, wind_direction, time, wavelength, phase, steepness, amplitude);

            wind_direction += (fract * dir);
            dir = dir * -1.0;
            fract += fract;
        }
        return output;
    }

)
