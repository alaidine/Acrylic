#pragma once

#include "Core.h"

namespace Acrylic {
	class AC_API Application
	{
	public:
		Application();
		virtual ~Application();

		void Run();
	};

	// To be defined in client
	Application* CreateApplication();
}
