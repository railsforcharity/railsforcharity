require 'spec_helper'

describe UsersController do
  let(:project) { create(:project) }

  login_user

  describe '#save_preferences' do
    before :each do
      @request.env['HTTP_REFERER'] = user_preferences_path(user)
    end

    def action
      post :save_preferences, {"project_id"=> project.id, "preferences" => {"new_task"=>"1", "task_assigned"=>"1", "task_unassigned"=>"0"} }
    end

    context 'success' do
      it 'saves users preferences' do
        action
        preference = Preference.find_by_user_id_and_entity_id_and_entity_type(user, project.id, 'Project')
        preference.should_not be_nil
        preference.properties.should_not be_nil
      end

      it 'sets the correct objects' do
        action
        preference = Preference.find_by_user_id_and_entity_id_and_entity_type(user, project.id, 'Project')
        preference.user.should == user
        preference.entity.should == project
      end

      it 'sets the correct properties' do
        action
        preference = Preference.find_by_user_id_and_entity_id_and_entity_type(user, project.id, 'Project')
        preference.properties["new_task"].should == "1"
        preference.properties["task_unassigned"].should be_nil
      end

      it 'sets the flash message' do
        action
        should set_the_flash.to('Saved your preferences for the selected project.')
      end
    end

    context 'failure' do
      it 'sets the flash message' do
        Preference.any_instance.stub(:save).and_return(false)
        action
        should set_the_flash.to('Failed to save preferences.')
      end
    end
  end
end
