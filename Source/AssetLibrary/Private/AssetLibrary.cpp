// Copyright Epic Games, Inc. All Rights Reserved.

#include "AssetLibrary.h"
#include "Misc/Paths.h"
#include "Misc/MessageDialog.h"

#include "Interfaces/IPluginManager.h"

#define LOCTEXT_NAMESPACE "FAssetLibraryModule"

void FAssetLibraryModule::StartupModule()
{
	FString ShadersDirectory = FPaths::Combine(IPluginManager::Get().FindPlugin(TEXT("AssetLibrary"))->GetBaseDir(), TEXT("Shaders"));
	AddShaderSourceDirectoryMapping("/AssetLibrary", ShadersDirectory);
	UE_LOG(LogTemp, Warning, TEXT("[AssetLibrary][Info] Added Asset Library shaders path to active include directories."));
}

void FAssetLibraryModule::ShutdownModule()
{
	// This function may be called during shutdown to clean up your module.  For modules that support dynamic reloading,
	// we call this function before unloading the module.
}

bool FAssetLibraryModule::SupportsDynamicReloading()
{
	return true;
}

#undef LOCTEXT_NAMESPACE
	
IMPLEMENT_MODULE(FAssetLibraryModule, AssetLibrary)