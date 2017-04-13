package EPrints::Plugin::Export::DC_Ext;

use base qw/ EPrints::Plugin::Export::DC /;

use strict;
use Time::Piece;

sub convert_dataobj
{
	my( $self, $eprint ) = @_;

	my @dcdata = ();

	# Get standard DC metadata from superclass
	my $data_ref = $self->SUPER::convert_dataobj($eprint);
	push @dcdata, @$data_ref;

	# Show extended metadata for FP7 projects
	# Would be nice to only show this for the relevant set but I don't think that information
	# makes it past the oai2 CGI script
	if( $eprint->exists_and_set( "fp7_project" ) && $eprint->get_value( "fp7_project" ) eq "yes" )
	{
		push @dcdata, [ "type", $eprint->get_value( "fp7_type" ) ] if($eprint->exists_and_set( "fp7_type" ));
		push @dcdata, [ "relation", $eprint->get_value( "fp7_project_id" ) ] if($eprint->exists_and_set( "fp7_project_id" ));

		my $embargoed = 0;
		my @documents = $eprint->get_all_documents();
		foreach ( @documents )
		{
			if( !$_->is_public)
			{
				my $embargo = $_->get_value("date_embargo");

				if($embargo != "")
				{
					$embargoed = 1;

					# EPrints embargo date may be just be a year or year/month.
					# Need to normalise and format as per guidelines
					if( length $embargo == 4)
					{
						$embargo = $embargo . "-12-31";
					}
					elsif( length $embargo == 7)
					{
						my $tp = Time::Piece->strptime( $embargo, "%Y-%m" );
						$embargo = "$embargo-".$tp->month_last_day;
					}

					push @dcdata, [ "date", "info:eu-repo/date/embargoEnd/" . $embargo ] ;
				}
			}
		}

		if($embargoed)
		{
			# Override anything set in the metadata if we have an embargo in force
			push @dcdata, [ "rights", "info:eu-repo/semantics/embargoedAccess" ];
		}
		else
		{
			push @dcdata, [ "rights", $eprint->get_value( "access_rights" ) ] if($eprint->exists_and_set( "access_rights" ));
		}
	}

	return \@dcdata;
}

1;
