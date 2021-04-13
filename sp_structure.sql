create procedure CREATE_SCHEMA (@schemaName nvarchar(150)) as 
begin
	if not exists (select * from sys.schemas where name = @schemaName)
	begin
		exec ('CREATE SCHEMA '+@schemaName)
	end
end;

create procedure CREATE_TABLE (@tableSchema nvarchar(150), @tableName nvarchar (500), @fieldDef nvarchar(500)) as 
begin
	declare @tableWithSchema nvarchar (500)
	set @tableWithSchema='['+@tableSchema+'].[' + @tableName+']'
	if not exists (select * from sys.objects where object_id = object_id(@tableWithSchema) and type in (N'U'))
	begin
		declare @command nvarchar(500)
		set @command = 'CREATE TABLE ' + @tableWithSchema + '(' + @fieldDef + ')'
		exec (@command)
	end
end;

create procedure ADD_COL @tableSchema nvarchar(150), @tableName nvarchar (150), @columnName nvarchar(150) , @datatype nvarchar(150), @valorNuloSiPermiteNulo int, @defaultValue nvarchar(150) as  
begin
	declare @command nvarchar(1000)
	declare @updateData nvarchar(1000)
	declare @tableWithSchema nvarchar (500)

	set @tableWithSchema='['+@tableSchema+'].' + @tableName
	if col_length(@tableWithSchema,@columnName) is null
		begin
			set @command = 'alter table ' + @tableWithSchema + ' add ' + @columnName + ' ' + @datatype
			exec (@command)
			if not @defaultValue is null
			begin
				set @updateData = 'update ' + @tableWithSchema + ' set ' + @columnName + ' = ' + @defaultValue + ' where ' + @columnName + ' is null'
				exec (@updateData)
				set @command = 'alter table ' + @tableWithSchema + ' add constraint DF_' + @tableName + '_' + @columnName + ' ' + ' default ' + @defaultValue + ' for ' + @columnName
				exec (@command)
			end

			if not  @valorNuloSiPermiteNulo is null
			begin
				set @command = 'alter table ' + @tableWithSchema + ' alter column ' + @columnName + ' ' + @datatype + ' not null'
				exec (@command)
			end
		end
	else
		begin
			
			declare @hasPrecision int
			declare @hasScale int

			declare @dataTypeWithPrecision varchar(max)
			declare @dataTypeWithScale varchar(max)

			declare @tableAllowNull int
			declare @tableDefaultValue varchar (500)
			declare @tableDataType varchar(100)
			declare @tablePrecision int --longitud de campo
			declare @tableScale int -- decimales

			declare @newValueAllowNull int
			declare @newValueDefaultValue varchar (500)
			declare @newValueDataType varchar(100)
			declare @newValuePrecision int --longitud de campo
			declare @newValueScale int -- decimales

			set @dataTypeWithPrecision = 'numeric|decimal|money|smallmoney|char|varchar|nvarchar|binary|nvarbinary'
			set @dataTypeWithScale = 'numeric|decimal|money|smallmoney'

			select @tableDefaultValue=object_definition(default_object_id) FROM   sys.columns WHERE  name =@columnName AND object_id = object_id(@tableWithSchema)
			if @tableDefaultValue is null
				set @tableDefaultValue = ''

			set @tableAllowNull = COLUMNPROPERTY( OBJECT_ID(@tableWithSchema),@columnName,'AllowsNull') 
			if @tableAllowNull is null
				set @tableAllowNull = 0

			select @tableDataType = lower(DATA_TYPE) from INFORMATION_SCHEMA.COLUMNS where TABLE_SCHEMA=@tableSchema and TABLE_NAME = @tableName AND COLUMN_NAME = @columnName

			set @hasPrecision = iif(charindex(@tableDataType, @dataTypeWithPrecision)>0, 1, 0)
			set @hasScale = iif(charindex(@tableDataType, @dataTypeWithScale)>0, 1, 0)
				
			set @tablePrecision = COLUMNPROPERTY( OBJECT_ID(@tableWithSchema),@columnName,'PRECISION') 
			if @tablePrecision is null or @hasPrecision=0
				set @tablePrecision = 0
			
			set @tableScale = COLUMNPROPERTY( OBJECT_ID(@tableWithSchema),@columnName,'Scale') 
			if @tableScale is null or @hasScale=0
				set @tableScale = 0
			print '@valorNuloSiPermiteNulo'
			print  @valorNuloSiPermiteNulo
			if not @valorNuloSiPermiteNulo is null
				set @newValueAllowNull = 0
			else
				set @newValueAllowNull = 1
			
			set @newValueDefaultValue = @defaultValue
			if @defaultValue is null
				set @newValueDefaultValue = ''

			if @tableDefaultValue!=@newValueDefaultValue
				begin
					set @newValueDefaultValue='('+@newValueDefaultValue+')'
				end
			if @tableDefaultValue!=@newValueDefaultValue
				begin
					set @newValueDefaultValue='('+@newValueDefaultValue+')'
				end
			
			set @newValuePrecision = 0
			set @newValueScale = 0
			if charindex('(', @dataType)>0 and charindex(')', @dataType)>0
				begin
				set @newValueDataType = ltrim(rtrim(substring(@dataType, 1, charindex('(', @dataType)-1)))
				if charindex(',', @dataType)>0
					begin
						set @newValuePrecision = convert(int, substring(@dataType, charindex('(', @dataType)+1, charindex(',', @dataType) - charindex('(' , @dataType) - 1))
						set @newValueScale = convert(int, substring(@dataType, charindex(',', @dataType)+1, charindex(')', @dataType) - charindex(',' , @dataType) - 1))
					end
				else
					begin
						set @newValuePrecision = convert(int, substring(@dataType, charindex('(', @dataType)+1, charindex(')', @dataType) - charindex('(' , @dataType) - 1))
						set @newValueScale = 0
					end
				end
			else
				begin
				set @newValueDataType = @dataType
				end

			print 'dataType old/new'
			print @tableDataType
			print @newValueDataType

			print 'precision old/new'
			print @tablePrecision
			print @newValuePrecision

			print 'scale old/new'
			print @tableScale
			print @newValueScale

			print 'allow null old/new'
			print @tableAllowNull
			print @newValueAllowNull
			
			print 'DefaultValue old/new'
			print @tableDefaultValue
			print @newValueDefaultValue


			set @command=''
			if @tableDataType !=@newValueDataType or @tablePrecision!=@newValuePrecision or @tableScale!=@newValueScale or @tableAllowNull!=@newValueAllowNull
				begin
					if exists (select * from sysobjects where xtype = 'D' and name = 'DF_' + @tableName + '_' + @columnName)
						begin
							set @command = 'alter table ' + @tableWithSchema + ' drop DF_' + @tableName + '_' + @columnName
							print @command
							exec (@command)
						end 
					set @command = 'alter table ' + @tableWithSchema + ' alter column ' + @columnName + ' ' + @datatype
					if @tableAllowNull!=@newValueAllowNull and @newValueAllowNull=0
						begin
							set @command = @command + ' not null'
						end
					print @command
					exec (@command)
				end
				
			
			if @newValueDefaultValue!=@tableDefaultValue and len(@newValueDefaultValue)>0
				begin
				if exists (select * from sysobjects where xtype = 'D' and name = 'DF_' + @tableName + '_' + @columnName)
					begin
						set @command = 'alter table ' + @tableWithSchema + ' drop DF_' + @tableName + '_' + @columnName
						print @command
						exec (@command)
					end 

				set @updateData = 'update ' + @tableWithSchema + ' set ' + @columnName + ' = ' + @defaultValue + ' where ' + @columnName + ' is null'
				print @updateData
				exec (@updateData)

				set @command = 'alter table ' + @tableWithSchema + ' add constraint DF_' + @tableName + '_' + @columnName + ' ' + ' default ' + @defaultValue + ' for ' + @columnName
				print @command
				exec (@command)
				end
		end
end;

create procedure ADD_PK @tableSchema nvarchar(150), @tableName nvarchar (150), @columnName nvarchar(150) as
begin

	declare @command nvarchar(1000)
	declare @tableWithSchema nvarchar (500)
	set @tableWithSchema='['+@tableSchema+'].' + @tableName
	if not exists (select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_TYPE = 'PRIMARY KEY' and TABLE_NAME = @tableName and TABLE_SCHEMA = @tableSchema )
		set @command = 'alter table ' + @tableWithSchema + ' add constraint pk_' +@tableSchema+'_'+ @tableName + ' primary key (' + @columnName + ')'

	exec (@command)
	
end;


create procedure ADD_FK @tableSchema nvarchar(150), @tableName nvarchar (150), @columnNameSource nvarchar(150), @tableSchemaDest nvarchar(150), @tableNameDest nvarchar (150), @columnNameDest nvarchar(150)  as

begin

	declare @command nvarchar(1000), @fkName nvarchar(1000)
	declare @tableWithSchema nvarchar (500)
	set @tableWithSchema='['+@tableSchema+'].' + @tableName
	set @fkName =  @tableSchema+'_'+@tableName + '_' + @columnNameSource + '_fkey'
	if not exists (select * from sys.objects o where o.object_id = object_id(N'['+ @tableSchema +'].['+@fkName+']') and OBJECTPROPERTY(o.object_id, N'IsForeignKey') = 1)
	begin
		set @command = 'alter table ' + @tableWithSchema + ' add constraint ' + @fkName + ' foreign key ([' + @columnNameSource + ']) references ['+@tableSchemaDest+'].[' + @tableNameDest + '] ([' + @columnNameDest + '])'
		exec (@command)
	end
	
end;


create procedure DEL_UNQ @tableSchema nvarchar(150),@tableName nvarchar (150), @uniqueNumber int as
begin

	declare @command nvarchar(1000)
	declare @indexName nvarchar(50)
	declare @tableWithSchema nvarchar (500)

	set @indexName = @tableSchema + '_' + @tableName + '_unique_' + cast(@uniqueNumber as nvarchar(10))
	set @tableWithSchema='['+@tableSchema+'].' + @tableName

	if exists(select * from sys.indexes where name = @indexName and object_id = object_id(@tableWithSchema))
		begin
			set @command = 'alter table ' + @tableWithSchema + ' drop constraint ' + @indexName 
			exec (@command)
		end	
end;


create procedure ADD_UNQ @tableSchema nvarchar(150),@tableName nvarchar (150), @columnName nvarchar(150), @uniqueNumber int as
begin

	declare @command nvarchar(1000)
	declare @indexName nvarchar(50)
	declare @tableWithSchema nvarchar (500)

	set @indexName = @tableSchema + '_' + @tableName + '_unique_' + cast(@uniqueNumber as nvarchar(10))
	set @tableWithSchema='['+@tableSchema+'].' + @tableName

	if not exists(select * from sys.indexes where name = @indexName and object_id = object_id(@tableWithSchema))
		begin
			set @command = 'alter table ' + @tableWithSchema + ' add constraint ' + @indexName + ' unique (' + @columnName + ') on [Index]'
			exec (@command)
		end	
end;

create procedure ADD_UNQ2 @tableSchema nvarchar(150),@tableName nvarchar (150), @columnName nvarchar(150), @uniqueNumber int, @condition varchar(200)=null as
begin

	declare @command nvarchar(1000)
	declare @indexName nvarchar(50)
	declare @tableWithSchema nvarchar (500)

	set @indexName = @tableSchema + '_' + @tableName + '_unique_' + cast(@uniqueNumber as nvarchar(10))
	set @tableWithSchema='['+@tableSchema+'].' + @tableName

	if not exists(select * from sys.indexes where name = @indexName and object_id = object_id(@tableWithSchema))
		begin
			set @command = 'create unique NONCLUSTERED INDEX ' + @indexName  + ' ON  '+ @tableWithSchema + ' (' + @columnName + ') '
			if (not @condition is null)
			begin
				set @command = @command + ' where ' + @condition
			end
			exec (@command)
		end	
end;


create procedure DROP_VIEW (@schemaName nvarchar(150), @viewName nvarchar(150)) as 
begin
		exec ('DROP VIEW ' + @schemaName + '.' + @viewName)
end;

create procedure CREATE_VIEW (@schemaName nvarchar(150), @viewName nvarchar(150), @view nvarchar(4000)) as 
begin
	if not exists (select * from sys.views where name = @viewName)
	begin
		exec ('CREATE VIEW ' + @schemaName + '.' + @viewName + ' WITH SCHEMABINDING as ' +@view)
	end
end;

create procedure DROP_CREATE_VIEW (@schemaName nvarchar(150), @viewName nvarchar(150), @view nvarchar(4000)) as 
begin
	if exists (select * from sys.views where name = @viewName)
	begin
		exec ('DROP VIEW ' + @schemaName + '.' + @viewName)
	end
	exec ('CREATE VIEW ' + @schemaName + '.' + @viewName + ' WITH SCHEMABINDING as ' +@view)
end;

create procedure ADD_IDX @tableSchema nvarchar(150),@tableName nvarchar (150), @columnName nvarchar(150), @indexName nvarchar (150) as
begin

	declare @command nvarchar(1000)
	declare @indexNameSave nvarchar(50)
	declare @tableWithSchema nvarchar (500)

	set @indexNameSave = 'index_' + @tableSchema + '_' + @indexName
	set @tableWithSchema='['+@tableSchema+'].' + @tableName

	if not exists(select * from sys.indexes where name = @indexNameSave and object_id = object_id(@tableWithSchema))
		begin
		set @command = 'create index ' + @indexNameSave + ' on ' + @tableWithSchema + ' (' + @columnName + ') on [Index]'
		exec (@command)
		end	
end;

create procedure ADD_UNQ_CLUSTERED_INDEX @tableSchema nvarchar(150),@tableName nvarchar (150), @columnName nvarchar(150), @indexName nvarchar (150) as
begin

	declare @command nvarchar(1000)
	declare @indexNameSave nvarchar(50)
	declare @tableWithSchema nvarchar (500)

	set @indexNameSave = 'uniq_clustered_index_' + @tableSchema + '_' + @indexName
	set @tableWithSchema='['+@tableSchema+'].' + @tableName

	if not exists(select * from sys.indexes where name = @indexNameSave and object_id = object_id(@tableWithSchema))
		begin
		set @command = 'create unique clustered index ' + @indexNameSave + ' on ' + @tableWithSchema + ' (' + @columnName + ') on [Index]'
		exec (@command)
		end	
end;

create procedure DEL_COL @tableSchema nvarchar(150), @tableName nvarchar (150), @columnName nvarchar(150) as  
begin
	declare @tableWithSchema nvarchar (500)
	declare @command nvarchar (500)

	set @tableWithSchema=@tableSchema+'.'+@tableName

	if  col_length(@tableWithSchema,@columnName) is not null
	begin
		set @command = 'alter table ' + @tableWithSchema + ' drop column ' + @columnName
		exec (@command)
	end
end;

create procedure RESEED_ID_IF_ACTUAL_LESS_THAN_NEW_VALUE(@tableSchema varchar(150), @tableName varchar (150), @newValue int) as  
begin
	declare @current_identity int
	declare @schemaAndTable varchar(200)
	set @schemaAndTable = @tableSchema+'.'+@tableName
	select @current_identity = IDENT_CURRENT(@schemaAndTable)
	if (@current_identity<@newValue)
		begin
		DBCC CHECKIDENT(@schemaAndTable, RESEED, @newValue)
		end
end;


create procedure DEL_FK @tableSchema nvarchar(150), @tableName nvarchar (150), @columnNameSource nvarchar(150) AS
begin

	declare @command nvarchar(1000), @fkName nvarchar(1000)
	declare @tableWithSchema nvarchar (500)
	set @tableWithSchema='['+@tableSchema+'].' + @tableName
	set @fkName =  @tableSchema+'_'+@tableName + '_' + @columnNameSource + '_fkey'
	if exists (select * from sys.objects o where o.object_id = object_id(N'['+ @tableSchema +'].['+@fkName+']') and OBJECTPROPERTY(o.object_id, N'IsForeignKey') = 1)
	begin
		set @command = 'alter table ' + @tableWithSchema + ' drop constraint ' + @fkName
		exec (@command)
	end
	
end;

