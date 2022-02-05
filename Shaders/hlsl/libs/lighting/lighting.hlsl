#pragma once
#include "../defines.hlsl"


container(Lighting,

    // Sand rendering in Journey https://slideplayer.com/slide/10552047/
    float OrenNayarDiffuse(float3 lightVecWS, float3 viewVecWS, float3 normalWS, float roughness)
    {
        float VdotN = dot(viewVecWS, normalWS);
        float LdotN = dot(lightVecWS, normalWS);
        float cos_theta_i = LdotN;
        float theta_r = acos(VdotN);
        float theta_i = acos(cos_theta_i);
        float cos_phi_diff = dot(
            normalize(viewVecWS - normalWS * VdotN),
            normalize(lightVecWS - normalWS * LdotN)
        );
        float alpha = max(theta_i, theta_r);
        float beta = min(theta_i, theta_r);
        float sigma2 = roughness * roughness;
        float a = 1.0f - 0.5f * sigma2 / (sigma2 + 0.33f);
        float b = 0.45f * sigma2 / (sigma2 + 0.09f);

        float output = saturate(cos_theta_i);
        output *= (a + (b * saturate(cos_phi_diff) * sin(alpha) * tan(beta)));

        return output;
    }


    float3 Specular(float3 world_camera_pos, float3 world_pos, float3 world_light_dir, float3 light_colour, float3 world_nml)
    {
        float3 eyeVec = normalize(world_camera_pos - world_pos);
        float3 reflVec = normalize( reflect(world_light_dir, world_nml) );
        float specFactor = dot(eyeVec, reflVec);
        return light_colour * specFactor;
    }

)