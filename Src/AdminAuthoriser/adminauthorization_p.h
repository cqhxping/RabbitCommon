#ifndef RABBITCOMMON_ADMINAUTHORIZATION_P_H
#define RABBITCOMMON_ADMINAUTHORIZATION_P_H

#include "adminauthoriser.h"

namespace RabbitCommon
{

class RABBITCOMMON_EXPORT CAdminAuthorization : public CAdminAuthoriser
{
public:
	bool hasAdminRights() override;
	bool executeAsAdmin(const QString &program, const QStringList &arguments) override;
};

}

#endif // RABBITCOMMON_ADMINAUTHORIZATION_P_H
