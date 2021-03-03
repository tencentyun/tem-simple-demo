SERVICES:=eureka-consumer eureka-provider consul-consumer consul-provider

$(foreach ITEM,$(SERVICES),$(eval $(call dockerbuild0,$(ITEM))))

DOCKER_REPO:=tem-demo

define dockerbuild
docker build --build-arg NAME=$(1) \
	-t $(DOCKER_REPO):$(1)-$(2) \
	 .

endef

define dockerbuild-all
$(foreach ITEM,$(SERVICES),$(call dockerbuild,$(ITEM),$(1)))
endef

define gen-hoxton
cat pom-template.xml | sed 's/0.0.1-SNAPSHOT/0.0.1-Hoxton-SNAPSHOT/' > pom.xml
endef

define gen-greenwich
cat pom-template.xml | sed 's/0.0.1-SNAPSHOT/0.0.1-Greenwich-SNAPSHOT/' | sed 's/Hoxton.SR9/Greenwich.SR6/' | sed 's/2.3.6.RELEASE/2.1.18.RELEASE/' > pom.xml
endef

define gen-finchley
cat pom-template.xml | sed 's/0.0.1-SNAPSHOT/0.0.1-Finchley-SNAPSHOT/' | sed 's/Hoxton.SR9/Finchley.SR4/' | sed 's/2.3.6.RELEASE/2.0.9.RELEASE/' > pom.xml
endef

gen-pom-hoxton:
	$(call gen-hoxton)

gen-pom-greenwich:
	$(call gen-greenwich)

gen-pom-finchley:
	$(call gen-finchley)

build-all:
	$(call gen-hoxton)
	mvn clean package -Dmaven.test.skip=true -Dmaven.javadoc.skip=true
	$(call dockerbuild-all,0.0.1-hoxton)

	$(call gen-greenwich)
	mvn clean package -Dmaven.test.skip=true -Dmaven.javadoc.skip=true
	$(call dockerbuild-all,0.0.1-greenwich)

	$(call gen-finchley)
	mvn clean package -Dmaven.test.skip=true -Dmaven.javadoc.skip=true
	$(call dockerbuild-all,0.0.1-finchley)

# Not working now
#	@cat pom-template.xml | sed 's/0.0.1-SNAPSHOT/0.0.1-Edgware-SNAPSHOT/' | sed 's/Hoxton.SR9/Edgware.SR6/' | sed 's/2.3.6.RELEASE/1.5.22.RELEASE/' > pom.xml
#	mvn clean package -Dmaven.test.skip=true -Dmaven.javadoc.skip=true
#	$(call dockerbuild-all,0.0.1-edgware)

# Recover pom.xml
	@cp pom-template.xml pom.xml

.PHONY: build-all
