/* create an svg drawing */

var draw = SVG('drawing')


var boxDiff = 20


/* draw rectangle */

//var symbol = draw.symbol()
var group = draw.nested()
var ruleSymbol = draw.defs()

var ruleDef = ruleSymbol.polygon("30,00 70,00 100,30 100,70 70,100 30,100 00,70 00,30 30,00")
    .fill('#d3ffff').stroke({ color: '#6b98ab', width: 2 })
var familyDef = ruleSymbol.polygon("20,00 120,00 140,20 140,80 00,80 00,20 20,00")
    .fill('#d3fdda').stroke({ color: '#6b98ab', width: 2 })
var familyDef_box = familyDef.rbox()

group.move(20,20)

var testrules = {
    'key': 'BD0020_001',
    'text' : 'Aussetzung Fahrerlaubnis bestimmen',
    'families' : [
        [ 'BD0020_001', 'RF0055_001', 'Aussetzung Fahrerlaubnis'],
            [ 'RF0055_001', 'RF0054_001', 'Test Psyche'],
                [ 'RF0054_001', 'RF0051_001', 'Bewertung Fahrverhalten'],
                   [ 'RF0051_001', 'RF0051_002', 'Bewertung Fahrverhalten2'],
                [ 'RF0054_001', 'RF0051_003', 'Bewertung Fahrverhalten3'],
                [ 'RF0054_001', 'RF0051_004', 'Bewertung Fahrverhalten4'],
                    [ 'RF0051_004', 'RF0051_007', 'Bewertung Fahrverhalten7'],
                    [ 'RF0051_004', 'RF0051_008', 'Bewertung Fahrverhalten8'],
            [ 'RF0055_001', 'RF0052_001', 'Test Physis'],
                [ 'RF0052_001', 'RF0055_002', 'Sehtest'],
                [ 'RF0052_001', 'RF0050_001', 'Reaktionstest'],
                    [ 'RF0050_001', 'RF0050_002', 'Reaktionstest2'],
                    [ 'RF0050_001', 'RF0050_003', 'Reaktionstest3']
    ]
}

createDiagram(group, testrules)
group.animate().scale(0.5, 0.5)

function createDiagram(group, ruleStructure) {
    var key = testrules['key']
    var text = testrules['text']
    var families = testrules['families']
    var elementCache = {}
    
    elementCache[key] = createRoot(group, key+'-'+text)
    for (i=0; i<families.length; ++i) {
        var parentKey = families[i][0]
        var childKey = families[i][1]
        var childText = families[i][2]
        var parent = elementCache[parentKey]
        if (parent) {
            //if (childKey == 'RF0051_007') { debugger }
            if (!elementCache[childKey]) {
                elementCache[childKey] = addFamily(parent, childKey+'-'+childText)
            } else {
              console.log('error child arlready exists '+childKey)
            throw 'error child arlready exists '+childKey
            }
        } else {
            console.log('error parent not found '+parentKey)
            throw 'error parent not found '+parentKey
        }
    }
}

function createTextInBox(group, node, text) {
    var bbox = node.rbox()
    var t = group.text(text.replace(/-/g, ': ').replace(/ /g, '\n'))
        .font({
          family:   'Helvetica'
            , size:     12
            , anchor:   'bottom'
            , leading:  '1'
        })
    var textbbox = t.rbox()
    t
        .dx(bbox.x + bbox.w/2 - textbbox.w/2)
        .dy(bbox.y + bbox.h/2 - textbbox.h/2)

}
function createRoot(group, text) {
    var familyGroup = group.group()
    	.addClass('group-rule-family')
    var familyGroupElement = familyGroup.group()
        .addClass('group-element')
    var familyElement = familyGroupElement
        .use(ruleDef)
    createTextInBox(familyGroupElement, familyElement, text)

    familyGroup.group()
        .addClass('group-children')
    familyGroup.group()
        .addClass('group-connector')
    return familyGroup
}

/*familyGroup.path('M'+(family_box.x+family_box.w/2)+" "+family_box.y+" v-"+boxDiff)
        .fill('none').stroke({ color: '#6b98ab', width: 3 })*/

function balanceGroup(group, sortChildren) {
    if (group.hasClass('group-rule-family')) {
        var parentElementGroup = group.first()
        var parentChildrenGroup = group.get(1)
        if (sortChildren) {
            var lastX2 = 0;
            parentChildrenGroup.each(function(i) {
                var thisElem = this.first()
                var thisChildren = this.get(1)
                var thisConnector = this.get(2)
                thisConnector.first().remove()
                var childrenBox = thisChildren.rbox()
                if (i > 0) {
                    //var thisbox = this.rbox()
                    var elementBox = thisElem.rbox()
                    lastX2 += boxDiff
                    if (childrenBox.w > 0) {
                        thisElem.move(childrenBox.w/2-elementBox.w/2, 0)
                        lastX2 += childrenBox.w
                    } else {
                        lastX2 += elementBox.w
                    }
                } else {
                    lastX2 = childrenBox.x2
                }
            })
        }
        var elementBox = parentElementGroup.rbox()        
        var childrenBox = parentChildrenGroup.rbox()
        
        if (childrenBox.w/2-elementBox.w/2 != elementBox.x) {
            parentElementGroup.move(childrenBox.w/2-elementBox.w/2)
        }
        parentChildrenGroup.each(function(i) {
            connectFamilies(
                this.get(2),
                parentElementGroup,
                this.first()
            )
        })
        balanceGroup(getParentGroup(group), true)
    }
}

/* creates a new child unter existing family
    family is first element in its own group (parent)
    family parent group has 2 elements: familiy, children
    and is positioned right after the last one
 */
function addFamily(parentFamilyGroup, text) {
    /* get bbox from 2nd element in group */
    var parentElementGroup = parentFamilyGroup.first()
    var parentChildrenGroup = parentFamilyGroup.get(1)
    var parentConnectorGroup = parentFamilyGroup.get(2)

    var topPos = parentElementGroup.rbox().y2 + boxDiff
    var startPos = parentChildrenGroup.rbox().x2
    /* if children already in bucket then increment by a seperator */
    if (parentChildrenGroup.first()) { 
        startPos = parentChildrenGroup.rbox().x2 + boxDiff
    } else {
        startPos = parentElementGroup.rbox().x
    }

    /* create a group for whole rule-family and children within children of parent*/
    var familyGroup = parentChildrenGroup.group()
        .addClass('group-rule-family')
        .attr('id', 'group-rule-family-'+text)
    /* create a 1st  group for rule-family and add it to group
        position it right after the last child of parent including diff
    */
    var elementGroup = familyGroup.group()
            .addClass('group-element')
    var familyNew = elementGroup.use(familyDef)
        .addClass('rule-family')
        .move(
            startPos, topPos
        )
    createTextInBox(elementGroup, familyNew, text)
    /* create a 2nd empty group for children */
    familyGroup.group()
        .addClass('group-children')
    var connectorGroup = familyGroup.group()
        .addClass('group-connector')
    balanceGroup(parentFamilyGroup, false)
    connectFamilies(
        connectorGroup,
        parentElementGroup,
        elementGroup)
    return familyGroup
}

/* connectors */
function connectFamilies(connectorGroup, parentFamily, childFamily) {
    if (connectorGroup.first()) {
        connectorGroup.first().remove()
    }
    var pbox = parentFamily.rbox();
    var cbox = childFamily.rbox();
    var pathString = null
    var pathColor = null
    if (pbox.cx > cbox.cx) {
        pathString = 
            "M "+
            (pbox.x)+" "+
            (pbox.y + pbox.h/2)+" "+
            "h-"+(pbox.x - cbox.x - cbox.w/2)+" v "+(pbox.h/2+boxDiff)
        pathColor = '#6b98ab'
    } else if (pbox.cx < cbox.cx) {
        pathString = 
            "M "+
            (pbox.x2)+" "+
            (pbox.y + pbox.h/2)+" "+
            "h"+(cbox.x - pbox.x - cbox.w/2)+" v "+(pbox.h/2+boxDiff)
        pathColor = '#6b98ab'
    } else {
        pathString = 
            "M "+
            (pbox.x+pbox.w/2)+" "+
            pbox.y2+" "+
            " v "+(boxDiff)
        pathColor = '#6b98ab'
    }
    var connector = connectorGroup.path(pathString)
    connector.fill('none')
            .stroke({ color: pathColor, width: 3 })
            .addClass('rule-connector')
}

/* helper funcions */

function forEachChildGroup(group, callback) {
    group.each(function(i) {
        if (this.hasClass('group-rule-family')) {
            callback(group.first(), this)
        }
    })
}

function getParentGroup(group) {
    if (group.hasClass('group-rule-family')) {
        return group.parent().parent()
    } else if (group.hasClass('group-children')) {
        return group.parent()
    } else if (group.hasClass('group-children')) {
        return group.parent()
    } else {
        return null
    }
}

function selectClass (node, className) {
    var children = [];
    node.each(function(i) {
        if (this.hasClass(className)) {
            children.push(this)
        }
    })
    return children
}