#pragma once
#include "../defines.hlsl"


container(Samplers,

    // Sample a volume flipbook texture
    float4 Texture2DVolumeFlipbookSample(float3 uvw, Texture2D tex, float2 subImages)
    {
        float2 fsi = float2((subImages.x * subImages.y), subImages.y);
        float2 layer00 = (floor((fsi)*(frac(uvw).z + ((1/(subImages.x * subImages.y))*0)).xx)/subImages)+(frac(uvw.xy)/subImages);
        float2 layer01 = (floor((fsi)*(frac(uvw).z + ((1/(subImages.x * subImages.y))*1)).xx)/subImages)+(frac(uvw.xy)/subImages);
        
        return lerp(
            Texture2DSample(tex, View.MaterialTextureBilinearWrapedSampler, layer00),
            Texture2DSample(tex, View.MaterialTextureBilinearWrapedSampler, layer01),
            frac(frac(uvw.z)*(subImages.x * subImages.y))
            );
    }


    float4 VolumeFlipbook3D(Texture2D tex, float2 subImages, int steps, float stepsMultiplier, float3 windVec, float time, float3 uvw, float uvwScale, float3 camPos, float3 worldPos )
    {
        const float steps_distance = stepsMultiplier / steps;
        const float3 windOffset = (windVec * time);
        uvw = (-uvw / uvwScale) + windOffset;
        camPos = (camPos / uvwScale) + windOffset;
        const float3 camDir = normalize(camPos - worldPos);

        float4 currentDensity = 0;
        float3 currentPosition = uvw;

        for(int i = 0; i < steps; i++)
        {
            currentDensity += Texture2DVolumeFlipbookSample(currentPosition, tex, subImages);
            currentPosition += -camDir * steps_distance;
        }

        return 1 - (saturate( currentDensity / steps ));
    }

    float2 StochasticTriPlanarUVs(float3 positionWS, float3 vertexNormalWS, float scale, float seed, float hardness)
    {
        float2 output;
        positionWS = frac(positionWS * scale);

        const float2 uv_xy = positionWS.yx;
        const float2 uv_xz = positionWS.xz;
        const float2 uv_yz = positionWS.yz;

        const float weight_xy = Maths.CheapContrast(abs(vertexNormalWS.z), hardness);
        const float weight_xz = Maths.CheapContrast(abs(vertexNormalWS.y), hardness);
        const float weight_yz = Maths.CheapContrast(abs(vertexNormalWS.x), hardness);


        float sum = weight_xy + weight_xz + weight_yz;

        float seed_3 = seed * sum;
        if(seed_3 < weight_xy) { output = uv_xy; } else { 
            seed_3 -= weight_xy; 
            if(seed_3 < weight_xz) { output = uv_xz; } else {
                output = uv_yz;
            }
        }


        return output;
    }

)