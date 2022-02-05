#pragma once
#include "../defines.hlsl"


container(Tangent,

    float3 WorldVec(
        float3 tsNormal,    // Unpacked tangent space normal in [-1..1] range
        float3x3 matrixTNB  // 3x3 Matrix [Tangent, Binormal, Normal] in world space
        )
    {
        return mul(tsNormal, matrixTNB)
    }

)


container(Object,

    float4 ScreenPos(
        float3 oPos,        // Object space position
        float4x4 matrixWVP  // 4x4 Matrix [World, View, Projection]
        )
    {
        return mul(float4(oPos, 1), matrixWVP);
    }

    float4 WorldPos(
        float3 oPos,        // Object space position
        float4x4 matrixW    // 4x4 Matrix [World]
        )
    {
        return mul(float4(oPos, 1), matrixW);
    }

    float3 WorldVec(
        float3 oNml,        // Object space normal
        float4x4 matrixWIT  // 4x4 Matrix [World Inverse Transpose]
        )
    {
        return normalize( mul(float4(oNml, 0), matrixWIT).xyz );
    }

    // Returns the objects position in world space
    float3 Position(
        float4x4 matrixW    // World Matrix
        )
    {
        return Object2WorldPos(float3(0,0,0), matrixW).xyz;
    }

    // Returns the objects up vector in world space
    float3 Normal(
        float4x4 matrixWIT  // World inverse transpose matrix
        )
    {
        return Object2WorldVec(float3(0,1,0), matrixWIT);
    }

)