/**
https://www.shadertoy.com/view/3t23DD
*/
#pragma once
#include "../defines.hlsl"


container(Hash,

    float hash_11(float p)
    {
        p = frac(p * .1031);
        p *= p + 19.19;
        p *= p + p;
        return frac(p);
    }


    float hash_12(float2 p)
    {
        float3 p3  = frac(float3(p.xyx) * .1031);
        p3 += dot(p3, p3.yzx + 19.19);
        return frac((p3.x + p3.y) * p3.z);
    }


    float hash_13(float3 p3)
    {
        p3  = frac(p3 * .1031);
        p3 += dot(p3, p3.yzx + 19.19);
        return frac((p3.x + p3.y) * p3.z);
    }


    float2 hash_21(float p)
    {
        float3 p3 = frac(float3(p.xxx) * float3(.1031, .1030, .0973));
        p3 += dot(p3, p3.yzx + 19.19);
        return frac((p3.xx+p3.yz)*p3.zy);

    }


    float2 hash_22(float2 p)
    {
        float3 p3 = frac(float3(p.xyx) * float3(.1031, .1030, .0973));
        p3 += dot(p3, p3.yzx+19.19);
        return frac((p3.xx+p3.yz)*p3.zy);

    }


    float2 hash_23(float3 p3)
    {
        p3 = frac(p3 * float3(.1031, .1030, .0973));
        p3 += dot(p3, p3.yzx+19.19);
        return frac((p3.xx+p3.yz)*p3.zy);
    }


    float3 hash_31(float p)
    {
    float3 p3 = frac(float3(p.xxx) * float3(.1031, .1030, .0973));
    p3 += dot(p3, p3.yzx+19.19);
    return frac((p3.xxy+p3.yzz)*p3.zyx); 
    }


    float3 hash_32(float2 p)
    {
        float3 p3 = frac(float3(p.xyx) * float3(.1031, .1030, .0973));
        p3 += dot(p3, p3.yxz+19.19);
        return frac((p3.xxy+p3.yzz)*p3.zyx);
    }


    float3 hash_33(float3 p3)
    {
        p3 = frac(p3 * float3(.1031, .1030, .0973));
        p3 += dot(p3, p3.yxz+19.19);
        return frac((p3.xxy + p3.yxx)*p3.zyx);

    }


    float4 hash_41(float p)
    {
        float4 p4 = frac(float4(p.xxxx) * float4(.1031, .1030, .0973, .1099));
        p4 += dot(p4, p4.wzxy+19.19);
        return frac((p4.xxyz+p4.yzzw)*p4.zywx);
        
    }


    float4 hash_42(float2 p)
    {
        float4 p4 = frac(float4(p.xyxy) * float4(.1031, .1030, .0973, .1099));
        p4 += dot(p4, p4.wzxy+19.19);
        return frac((p4.xxyz+p4.yzzw)*p4.zywx);

    }


    float4 hash_43(float3 p)
    {
        float4 p4 = frac(float4(p.xyzx)  * float4(.1031, .1030, .0973, .1099));
        p4 += dot(p4, p4.wzxy+19.19);
        return frac((p4.xxyz+p4.yzzw)*p4.zywx);
    }


    float4 hash_44(float4 p4)
    {
        p4 = frac(p4  * float4(.1031, .1030, .0973, .1099));
        p4 += dot(p4, p4.wzxy+19.19);
        return frac((p4.xxyz+p4.yzzw)*p4.zywx);
    }

)