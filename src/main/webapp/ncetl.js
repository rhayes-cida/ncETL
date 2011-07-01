// Path to the blank image should point to a valid location on your server
Ext.BLANK_IMAGE_URL = 'images/s.gif';

Ext.onReady(function() {
	
	new Ext.container.Viewport({
			layout : 'fit',
			items : [
			{
				xtype: 'panel',
				title : "Dataset options",
				region: 'center',
				layout: 'anchor',
				border: false,
				defaults : {
					autoScroll: true
				},
				items : [{
					autoEl : {
						tag : 'a',
						href : 'ingests.jsp',
						html : 'Ingestors'
					},
					border : false
				},{
					autoEl : {
						tag : 'a',
						href : 'decorate.jsp',
						html : 'ncISO tools'
					},
					border : false
				},{
					autoEl : {
						tag : 'a',
						href : 'add_dataset.jsp',
						html : 'Add Dataset'
					},
					border : false     
				}]
			}
			]
		});
	
});