const d3 = require('d3');
const stateMapUtils = require('./state_map_utils');

require('../stylesheets/map.scss');

$(document).ready(() => {
    const stateMap = new stateMapUtils.Map();
    d3.json(stateMap.topojsonUrl).then((topology) => {
        const mapAssets = stateMapUtils.parseTopojson(stateMap, topology);
        const paths = stateMap.svgElement.selectAll('path')
        stateMap.svgElement.selectAll('path')
            .data(mapAssets.geojson.features)
            .enter()
            .append('path')
            .attr('class', 'actionmap-view-region')
            .attr('d', mapAssets.path)
            .attr('data-county-name', (d) => stateMap.counties[d.properties.COUNTYFP].name)
            .attr('data-county-fips-code', (d) => d.properties.COUNTYFP);

        paths.on('click', function(event, d) {
          const countyCode = d.properties.COUNTYFP;
          fetchRepresentatives
        });
        stateMapUtils.setupEventHandlers(stateMap);
    });
});

function fetchCountryRepresntatives(countyFipsCode) {
  const url = '/representatives?county_fips_code = ${countyFipsCode}';
  fetch(url)
  .then(response => {
    if (!response.ok) {
      throw new Error('HTTP error! Status: $(response.status)');
    }
    return response.json();
  })
  // .then(data => {
    // updateRepsUI(data);
  // })
  .catch(error => console.error('Error fetching reps:', error));
}
  
// function updateRepsUI(data) {
//   const reps = document.getElementById
// }