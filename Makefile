SHELL=/bin/bash -o pipefail

CHART_DIR = /tmp/temporal-helm-charts
.PHONY: package_chart
package_chart:
	rm -rf $(CHART_DIR) && mkdir -p $(CHART_DIR)
	helm dependencies update
	hack/package-chart . $(CHART_DIR) $(CHART_DIR)/index.yaml

.PHONY: publish_chart
publish_chart: package_chart
	git checkout gh-pages
	cp $(CHART_DIR)/* .
	git add .
	git commit -m "Release chart"
	git push origin gh-pages
	git checkout master
